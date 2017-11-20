load tracks track
ntr=length(track);
%ntr=50;
opt=optimset('display','final','maxiter',10000,'maxfunevals',10000,'tolfun',1e-6);
%maxcomp=3;
mode=true;
medi=true;
dt = datestr(now,'yyyy.mm.dd_HH_MM_SS');
maxcompArr = [1,2,3,4,5,6,8,10,12];

%===============================================================================
% main
cov
%for maxcomp=1:12
for maxcomp=3:12
  if maxcomp ~=maxcompArr
    continue
  end
  maxcomp
  for itr=1:ntr
      itr
      % construct gaussian mixture object
      ncomp=track(itr).ncomp;
      clear P Mu Sigma;
      for i=1:ncomp
          P(i)=track(itr).comp(i).weight;
          Mu(i,:)=track(itr).comp(i).par';
          Sigma(:,:,i)=diag2full(track(itr).comp(i).covm,5);
      end
      [~,ind]=sort(P,'descend');
      take=1:min(ncomp,maxcomp);
      P=P(ind(take));
      P=P/sum(P);
      Mu=Mu(ind(take),:);
      Sigma=Sigma(:,:,ind(take));
      gm=gmdistribution(Mu,Sigma,P);
      gmMu=track(itr).mixt.par';
      gmSigma=diag2full(track(itr).mixt.covm,5);
      tp=track(itr).tp';
      % mode
      if mode,mixtmode=fminsearch(@(x) -gm.pdf(x),gmMu,opt);end
      % mean
      mixtmean=sum(Mu.*repmat(P',1,5),1);
      % median
      if medi
      N=100000;
      r=gm.random(N);
      medifun=@(x) sum(sqrt(sum((r-x).^2,2)));
      mixtmedi=fminsearch(medifun,mixtmode,opt);
      end
      resmixtmean(itr,:)=mixtmean-tp;
      if mode,resmixtmode(itr,:)=mixtmode-tp;end
      if medi,resmixtmedi(itr,:)=mixtmedi-tp;end
      resbaseline(itr,:)=gmMu-tp;
  end

  m3 = m3function(mixtmode, mixtmean, mixtmedi, maxcomp, resmixtmean, resmixtmode, resmixtmedi, resbaseline);
% test is writing works
%  resmixtmean(1)=maxcomp;
%  resmixtmode(1)=maxcomp;
%  resmixtmedi(1)=maxcomp;
%  resbaseline(1)=maxcomp;
  saveAggregator(maxcomp, m3, resmixtmean, resmixtmode, resmixtmedi, resbaseline, dt);
end

%===============================================================================
% functions

function fullM=diag2full(diagM,dim)
ind=0;
for i=1:dim
    for j=1:i
        ind=ind+1;
        fullM(i,j)=diagM(ind);
        fullM(j,i)=diagM(ind);
    end
end
return
end

function m3=m3function(mixtmode, mixtmean, mixtmedi, maxcomp, resmixtmean, resmixtmode, resmixtmedi, resbaseline)
  m3(1,:)=mixtmode;    % mixtmode
  m3(2,:)=mixtmean;    % mixtmean
  m3(3,:)=mixtmedi;    % mixtmedi
  m3(4,:)=std(resmixtmean);    % standard deviation
  m3(5,:)=mad(resmixtmean,0);    % mean absolute deviation
  m3(6,:)=mad(resmixtmean,1);    % median absolute deviation
  m3(7,:)=std(resmixtmode);    % standard deviation
  m3(8,:)=mad(resmixtmode,0);    % mean absolute deviation
  m3(9,:)=mad(resmixtmode,1);    % median absolute deviation
  m3(10,:)=std(resmixtmedi);    % standard deviation
  m3(11,:)=mad(resmixtmedi,0);    % mean absolute deviation
  m3(12,:)=mad(resmixtmedi,1);    % median absolute deviation
  m3(13,:)=std(resbaseline);    % standard deviation
  m3(14,:)=mad(resbaseline,0);    % mean absolute deviation
  m3(15,:)=mad(resbaseline,1);    % median absolute deviation
  m3(16,1)=maxcomp;       % test if write works
  return
end

function savefunction_1=saveFunction(maxcomp, val, name, dt)
  path = strcat('matlab_output_', dt, '/maxcomp', num2str(maxcomp), '/output_', name, '.csv');
  csvwrite(path,val);
end

function savefunction_2=saveAggregator(maxcomp, m3, resmixtmean, resmixtmode, resmixtmedi, resbaseline, dt)
  path = strcat('matlab_output_', dt, '/maxcomp', num2str(maxcomp));
  status = mkdir(path);
  saveFunction(maxcomp, m3, 'm3', dt)
  saveFunction(maxcomp, resmixtmean, 'resmixtmean', dt)
  saveFunction(maxcomp, resmixtmode, 'resmixtmode', dt)
  saveFunction(maxcomp, resmixtmedi, 'resmixtmedi', dt)
  saveFunction(maxcomp, resbaseline, 'resbaseline', dt)
end
