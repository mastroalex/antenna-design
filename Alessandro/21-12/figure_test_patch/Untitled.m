L = 0.0156:0.0001:0.0163;
W = 0.034:0.0001:0.049;
load 'gamma.mat'
contourf(W,L,20*logGamma)
colorbar