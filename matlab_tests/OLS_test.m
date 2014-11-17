%% Create data
% Test data
X = 0:100;
Z = linspace(100,0,101);
Z = Z' * 0.2;
X = X';
Y = 0.75 * awgn(X+Z, -3);

%% 1D plots
figure()

% Plot scatter data
subplot(1,3,1);
scatter(X,Y);
hold;
subplot(1,3,2);
scatter(X,Y);
hold;
subplot(1,3,3);
scatter(X,Y);
hold;

% Solve using Matlab's OLS
subplot(1,3,1);
solved_matlab = lsqr([ones(size(Y)) X],Y);
plot(X, X*solved_matlab(2) + solved_matlab(1));
axis([0,100,0,100])
title(['Matlab OLS' mat2str(solved_matlab)])

% Solve using our non-distributed method.
A = X'*X;
b = X'*Y;
coeff = inv(A)*b;

subplot(1,3,2);
plot(X, X*coeff);
axis([0,100,0,100])
title('Simple OLS')

% Solve using our distributed method
m = length(X);
breaks = linspace(1,m,12);
A_sum = 0;
B_sum = 0;
for i=1:11
    X_slice = X(breaks(i):breaks(i+1));
    Y_slice = Y(breaks(i):breaks(i+1));
    A_piece = X_slice'*X_slice;
    B_piece = X_slice'*Y_slice;
    A_sum = A_sum + A_piece;
    B_sum = B_sum + B_piece;
end
coeff_dist = inv(A_sum)*B_sum

subplot(1,3,3);
plot(X, X*coeff_dist);
axis([0,100,0,100])
title('Distributed OLS')

%% Create a CSV
figure();
scatter3(X,Z,Y);
data_matrix = [X Z Y];
H = [X Z];
lsqr(H,Y)
csvwrite('/home/nharada/junkdata/blink_test.csv', data_matrix)

%% Solve using our distributed method
coeff_dist_matlab = lsqr(H,Y)

m = length(X);
H = [X Z];
breaks = linspace(1,m,12);
A_sum = 0;
B_sum = 0;
for i=1:11
    X_slice = H(breaks(i):breaks(i+1),:);
    Y_slice = Y(breaks(i):breaks(i+1),:);
    A_piece = X_slice'*X_slice;
    B_piece = X_slice'*Y_slice;
    A_sum = A_sum + A_piece;
    B_sum = B_sum + B_piece;
end
coeff_dist = inv(A_sum)*B_sum

