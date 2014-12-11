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
axis([950 10000050 0 0.7E-3])
xlabel('Table Size (Percentage)')
ylabel('Coefficient MSE')
title('Coefficient True Accuaracy vs Sample Size')
set(gca, 'XTickLabel', str2mat('0.01%', '0.1%', '1%', '10%', '100%'))

% set(gcf, 'PaperUnits', 'inches');
% x_width=3 ;y_width=3
% set(gcf, 'PaperPosition', [0 0 x_width y_width]); 
saveas(gcf,'accuracy.png')
%print('accuracy', '-depsc')

%% Plot confidence intervals
figure()
cis = data(:, {'CB1', 'CB2', 'CB3'});
cis = table2array(cis);
for i=1:size(cis, 1)
    confidences(i) = mean(cis(i,:));
end
semilogx(sizes, confidences, 'k-+','MarkerSize',10)
axis([950 10000050 0 0.7])
xlabel('Table Size (Percentage)')
ylabel('Average Confidence Interval Width')
title('Confidence Interval Width vs Sample Size')
set(gca, 'XTickLabel', str2mat('0.01%', '0.1%', '1%', '10%', '100%'))
saveas(gcf,'confidence.png')
% print('confidence', '-depsc')

%% Plot runtime
figure()
times = data(:, {'TrainTime', 'TestTime'});
times = table2array(times);
loglog(sizes, times(:, 1), 'k--+','MarkerSize',10)
hold on;
loglog(sizes, times(:, 2), 'k-x','MarkerSize',10)
axis([950 10000050 0 1e4])
xlabel('Table Size (Percentage)')
ylabel('Runtime (s)')
title('Runtime vs Sample Size')
set(gca, 'XTickLabel', str2mat('0.01%', '0.1%', '1%', '10%', '100%'))
legend('Approximation', 'Confidence Intervals')
saveas(gcf,'runtime.png')
%print('runtime', '-depsc')