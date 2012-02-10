%PARTIE AVEC REND FIXE
m = mean(RR);
rendSize = size(RR,1);
RRc = RR(1:rendSize,1:10) - ones(rendSize,1)*m;
Qin = RRc' * RRc/rendSize;

% 
% Q = [Q 0]
%     [0 0]
Q = [Qin zeros(10,1); zeros(1,11)];

% red fixe
Rf = 0.02;

% not used
r = zeros(11,1);

% somme x doit etre 1
A = ones(11,1)';

% somme invest > Re et investissement > 0
C = [[-m -Rf];-eye(11)];

% solinitial = x avec m max
solinit = zeros(11,1) ;
solinit(4)= 1;

tol = 1e-10;

% minisation du risque pour 
% ses valeurs de Re
ReVar = 0.0:0.002:0.041;

solfinal = [];

for d=ReVar,
 d = [-d; zeros(11,1) ]; 
 [sol,mult] = QPactivate(Q, r, A, C, d, solinit, tol)
 solm = sqrt((1-sol(11))*(1-sol(11))*sol(1:10)'*Qin*sol(1:10));
 solfinal = [solfinal solm];
end;

 disp(solfinal);

% Plot graphic
h = figure;
filename = 'fixerend';
p=plot(solfinal,ReVar,"linewidth", 4);
xlabel('sigma');
ylabel('Re');
print(h, '-depsc2', filename);
