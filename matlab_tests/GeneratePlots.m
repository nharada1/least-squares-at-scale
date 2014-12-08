data = readtable('performance.csv');
sizes = data(:, {'Size'});
sizes = table2array(sizes);


%% Plot coefficient training error
figure()
correct = [0 1 -2 3];
coeffs = data(:, {'Constant', 'B1', 'B2', 'B3'});
coeffs = table2array(coeffs);
for i=1:size(coeffs, 1)
    err(i) = mean((coeffs(i,:)-correct).^2);
end
loglog(sizes, err, 'k-+','MarkerSize',10)
axis([950 10000050 0 1e-3])
xlabel('Table Size')
ylabel('Coefficient Mean Square Error')
title('Coefficient True Accuaracy vs Sample Size')

%% Plot confidence intervals
figure()
cis = data(:, {'CB1', 'CB2', 'CB3'});
cis = table2array(cis);
for i=1:size(cis, 1)
    confidences(i) = sum(cis(i,:));
end
loglog(sizes, confidences, 'k-+','MarkerSize',10)
axis([950 10000050 0 2])
xlabel('Table Size')
ylabel('Sum of Confidence Intervals')
title('Coefficient Confidence Intervals vs Sample Size')

%% Plot runtime
figure()
times = data(:, {'TrainTime', 'TestTime'});
times = table2array(times);
loglog(sizes, times(:, 1), 'k--+','MarkerSize',10)
hold on;
loglog(sizes, times(:, 2), 'k-x','MarkerSize',10)
axis([950 10000050 0 1e4])
xlabel('Table Size')
ylabel('Runtime (s)')
title('Runtime vs Sample Size')

%% Set Plot Options
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );
set(0,'DefaultAxesFontSize',12)