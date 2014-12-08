%% 
mu = [0, 0, 0];
V = [5 -1 0; 1 5 0; 0 0 1];
D = [50 0 0; 0 1 0; 0 0 1];
sigma = V*D*inv(V);
R = mvnrnd(mu, sigma, 10000000);
csvwrite('/home/nharada/junkdata/synthetic.csv', R)

%% 
mu = [0, 0]
V = [5 -1; 1 5]
D = [20 0; 0 0.5]
sigma = V*D*inv(V)
R = mvnrnd(mu, sigma, 10000)
scatter(R(:,1), R(:,2))

%%
N = [100 1000 10000 100000 1000000];

for i=1:numel(N)
    bhat = [1,2,3];
    mu = 0;
    sigma = 1;
    X = normrnd(mu, sigma, [N(i) numel(bhat)]);
    Y = awgn(X * bhat', 0);
    result = lsqr(X, Y);
    results(i) = norm(result-bhat');
end
plot(results)

%%
N = 10e6;
bhat = [1,-2,3];
mu = 0;
sigma = 1;
X = normrnd(mu, sigma, [N numel(bhat)]);
Y = awgn(X * bhat', 0);
csvwrite('/home/nharada/junkdata/synthetic_known.csv', [X Y])
