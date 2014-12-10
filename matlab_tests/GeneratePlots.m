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
semilogx(sizes, err, 'k-+','MarkerSize',10)
xlabel('Table Size (Rows)')
set(0,'DefaultTextInterpreter', 'latex')
ylabel('Coefficient MSE - $E[ (\beta-\hat\beta)^2 ]$')
title('Coefficient True Accuaracy vs Sample Size')
print('accuracy', '-depsc')
ax1 = gca;
axis(ax1, [950 10000050 0 0.7e-3])
ax1_pos = ax1.Position;
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'Color','none');
set(ax2, 'xscale', 'linear')
axis(ax2, [0 1 0 0.7e-3])

%% Plot confidence intervals
figure()
cis = data(:, {'CB1', 'CB2', 'CB3'});
cis = table2array(cis);
for i=1:size(cis, 1)
    confidences(i) = mean(cis(i,:));
end
semilogx(sizes, confidences, 'k-+','MarkerSize',10)
axis([950 10000050 0 0.7])
xlabel('Table Size (Rows)')
ylabel('Average Confidence Interval Width')
title('Confidence Interval Width vs Sample Size')
print('confidence', '-depsc')

%% Plot runtime
figure()
times = data(:, {'TrainTime', 'TestTime'});
times = table2array(times);
loglog(sizes, times(:, 1), 'k--+','MarkerSize',10)
hold on;
loglog(sizes, times(:, 2), 'k-x','MarkerSize',10)
axis([950 10000050 0 1e4])
xlabel('Table Size (rows)')
ylabel('Runtime (s)')
title('Runtime vs Sample Size')
legend('Approximation', 'Confidence Intervals')
print('runtime', '-depsc')