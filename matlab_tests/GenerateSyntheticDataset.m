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