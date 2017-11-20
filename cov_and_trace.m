clear
dt = datestr(now,'yyyy.mm.dd_HH_MM_SS');
maxcompArr = [1,2,3,4,5,6,8,10,12];
inPath = 'matlab_output_revised_2017.10.18_14_37_42';
covtracematrix = []

%===============================================================================
% main

for maxcomp=1:12
  if maxcomp ~=maxcompArr
    continue
  end
  maxcomp

  resmixtmean = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_resmixtmean.csv'));
  resmixtmode = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_resmixtmode.csv'));
  resmixtmedi = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_resmixtmedi.csv'));
  resbaseline = load(strcat(inPath, '/maxcomp', num2str(maxcomp), '/output_resbaseline.csv'));

  covtracematrix=covtracefunction(maxcomp, covtracematrix, resmixtmean, resmixtmode, resmixtmedi, resbaseline)

  covmean = cov(resmixtmean);
  covmode = cov(resmixtmode);
  covmedi = cov(resmixtmedi);
  covbase = cov(resbaseline);

  saveAggregator(maxcomp, resmixtmean, resmixtmode, resmixtmedi, resbaseline, covmean, covmode, covmedi, covbase, dt);
end

saveFunctionOuside(maxcomp, covtracematrix, 'covtracematrix', dt)

%===============================================================================
% functions

function covtracematrix=covtracefunction(maxcomp, covtracematrix, resmixtmean, resmixtmode, resmixtmedi, resbaseline)
  m1(1,1) = trace(cov(resmixtmean));
  m1(1,2) = trace(cov(resmixtmode));
  m1(1,3) = trace(cov(resmixtmedi));
  m1(1,4) = trace(cov(resbaseline));

  if maxcomp == 1
    covtracematrix = m1
  else
    covtracematrix = [covtracematrix; m1]
  end

  return
end

function savefunction_1=saveFunction(maxcomp, val, name, dt)
  path = strcat('matlab_output_revised_', dt, '/maxcomp', num2str(maxcomp), '/output_', name, '.csv');
  csvwrite(path,val);
end

function savefunction_2=saveAggregator(maxcomp, resmixtmean, resmixtmode, resmixtmedi, resbaseline, covmean, covmode, covmedi, covbase, dt)
  path = strcat('matlab_output_revised_', dt, '/maxcomp', num2str(maxcomp));
  status = mkdir(path);
  saveFunction(maxcomp, resmixtmean, 'resmixtmean', dt)
  saveFunction(maxcomp, resmixtmode, 'resmixtmode', dt)
  saveFunction(maxcomp, resmixtmedi, 'resmixtmedi', dt)
  saveFunction(maxcomp, resbaseline, 'resbaseline', dt)
  saveFunction(maxcomp, covmean, 'covmean', dt)
  saveFunction(maxcomp, covmode, 'covmode', dt)
  saveFunction(maxcomp, covmedi, 'covmedi', dt)
  saveFunction(maxcomp, covbase, 'covbase', dt)
end

function savefunction_3=saveFunctionOuside(maxcomp, val, name, dt)
  path = strcat('matlab_output_revised_', dt, '/output_', name, '.csv');
  csvwrite(path,val);
end
