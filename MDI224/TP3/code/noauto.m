%PARTIE 1.4=========================
load RR.txt

m = mean(RR);
rendSize = size(RR,1);
RRc = RR(1:rendSize,1:10) - ones(rendSize,1)*m;
Q = RRc' * RRc/rendSize;

r = zeros(10,1);
A = ones(10,1)';
C = [-m;-eye(10)];

solinit = zeros(10,1) ;
solinit(3)= 1;
tol = 1e-10;

ReVar = 0.0:0.002:0.041;

solfinal = [];

for d=-ReVar,
 d = [d; zeros(10,1) ]; 
 [sol,mult] = QPactivate(Q, r, A, C, d, solinit, tol)
 solm = sqrt(sol'*Q*sol);
 disp(solm);
 solfinal = [solfinal solm];
end;

% Plot graphic
h = figure;
filename = 'parte14';
p=plot(solfinal,ReVar,"linewidth", 4);
xlabel('sigma');
ylabel('Re');
print(h, '-depsc2', filename);
