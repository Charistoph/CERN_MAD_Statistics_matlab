clear
dt = datestr(now,'yyyy.mm.dd_HH_MM_SS');
maxcompArr = [1,2,3,4,5,6,8,10,12];
inPath = 'matlab_output_revised_2017.10.18_14_37_42';

%===============================================================================
% main

for maxcomp=1:12
  if maxcomp ~=maxcompArr
    continue
  end
  maxcomp

  m3 = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_m3.csv'));
  resmixtmean = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_resmixtmean.csv'));
  resmixtmode = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_resmixtmode.csv'));
  resmixtmedi = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_resmixtmedi.csv'));
  resbaseline = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_resbaseline.csv'));

  m_temp = m3(1:3,:);

  m3=m3function(maxcomp, m_temp, resmixtmean, resmixtmode, resmixtmedi, resbaseline);

  saveAggregator(maxcomp, m3, resmixtmean, resmixtmode, resmixtmedi, resbaseline, dt);
end

%===============================================================================
% functions

function m3=m3function(maxcomp, m_temp, resmixtmean, resmixtmode, resmixtmedi, resbaseline)
  m3(1,:)=m_temp(1,:);    % mixtmode
  m3(2,:)=m_temp(2,:);    % mixtmean
  m3(3,:)=m_temp(3,:);    % mixtmedi
  m3(4,:)=std(resmixtmean);    % standard deviation
  m3(5,:)=mad(resmixtmean,0);    % mean absolute deviation
  m3(6,:)=mad(resmixtmean,1);    % median absolute deviation
  m3(7,:)=std(resmixtmode);
  m3(8,:)=mad(resmixtmode,0);
  m3(9,:)=mad(resmixtmode,1);
  m3(10,:)=std(resmixtmedi);
  m3(11,:)=mad(resmixtmedi,0);
  m3(12,:)=mad(resmixtmedi,1);
  m3(13,:)=std(resbaseline);
  m3(14,:)=mad(resbaseline,0);
  m3(15,:)=mad(resbaseline,1);
  m3(16,:)=maxcomp;       % test if write works
  return
end

function savefunction_1=saveFunction(maxcomp, val, name, dt)
  path = strcat('matlab_output_revised_', dt, '/maxcomp', num2str(maxcomp), '/output_', name, '.csv');
  csvwrite(path,val);
end

function savefunction_2=saveAggregator(maxcomp, m3, resmixtmean, resmixtmode, resmixtmedi, resbaseline, dt)
  path = strcat('matlab_output_revised_', dt, '/maxcomp', num2str(maxcomp));
  status = mkdir(path);
  saveFunction(maxcomp, m3, 'm3', dt)
  saveFunction(maxcomp, resmixtmean, 'resmixtmean', dt)
  saveFunction(maxcomp, resmixtmode, 'resmixtmode', dt)
  saveFunction(maxcomp, resmixtmedi, 'resmixtmedi', dt)
  saveFunction(maxcomp, resbaseline, 'resbaseline', dt)
end
