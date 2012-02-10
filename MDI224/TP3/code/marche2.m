load sp500em.mat
whos
m = mean (prices);
rendSize = 3448;
RRc = prices - ones(rendSize,1)*m;
Q = RRc' * RRc/rendSize;
disp(Q);