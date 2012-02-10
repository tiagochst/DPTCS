%PARTIE 1.4==========
load RR.txt

m = mean(RR);
rendSize = size(RR,1);
RRc = RR(1:rendSize,1:10) - ones(rendSize,1)*m;
Q = RRc' * RRc/rendSize;

r = zeros(10,1);
A = m-0.0002*ones(10,1)';
C = -m;

solinit = zeros(10,1) ;
solinit(3)= 1;
tol = 1e-10;

solfinal = [];
d = 0;

 [sol,mult] = QPactivate(Q, r, A, C, d, solinit, tol)
 solm = sqrt(sol'*Q*sol);
 disp(1/solm);
