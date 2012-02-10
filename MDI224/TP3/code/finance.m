% Marche 1

% On va lire le fichier RR.txt
% Pour faciliter (On a effacer le tete du fichier)
load RR.txt

%redement( RR, nActives,ReVar );
ReVar = 0.0:0.00025:0.1;
sigma = redement( RR, 10,ReVar  );
sigma3 = redement( RR, 3,ReVar  );
sigma5 = redement( RR, 5,ReVar  );

% Plot graphic
%  h = figure;
%  filename = 'redment10';
%  p=plot(sigma,ReVar,"linewidth", 4);
%  hold all
%  p=plot(sigma5,ReVar,"linewidth", 4);
%  hold all
%  p=plot(sigma3,ReVar,"linewidth", 4 );
%  hleg1 = legend('10','5','3');
%  xlabel('sigma');
%ylabel('Re');
%print(h, '-depsc2', filename);

%PARTIE 1.3.52=========================================================
ReVar = 0.0:0.00025:0.025;
[ sigmaRho1,sigmaRho2,sigmaRho3 ] = rendCov( RR, 2,ReVar);

% Plot graphic
%  h = figure;
%  filename = 'rho';
%  p=plot(sigmaRho1,ReVar,"linewidth", 4);
%  hold all
%  p=plot(sigmaRho2,ReVar,"linewidth", 4);
%  hold all
%  p=plot(sigmaRho3,ReVar,"linewidth", 4);
%  hleg1 = legend('-0.9','0','0.9');
%  xlabel('sigma');
%  ylabel('Re');
%  print(h, '-depsc2', filename);

%PARTIE FIxe=========================================================

m = mean(RR);
disp(m);
rendSize = size(RR,1);
RRc = RR(1:rendSize,1:10) - ones(rendSize,1)*m;
Qin = RRc' * RRc/rendSize;
Q = [Qin zeros(10,1); zeros(1,11)];
Rf=0.02;
r = zeros(11,1);
A = ones(11,1)';
%A =[];
C = [[-m -Rf];-eye(11)];

solinit = zeros(11,1) ;
solinit(4)= 1;
tol = 1e-10;

ReVar = 0.0:0.002:0.0538880;

solfinal = [];

for d=ReVar,
 d = [-d; zeros(11,1) ]; 
 [sol,mult] = QPactivate(Q, r, A, C, d, solinit, tol)
 solm = sqrt((1-sol(11))*(1-sol(11))*sol(1:10)'*Qin*sol(1:10));
 pente = 1/sqrt(sol(1:10)'*Qin*sol(1:10));
 disp('PENNNNTTE');
 disp((-d(1)-0.02)/solm);
 solfinal = [solfinal solm];
end;

 %disp(solfinal);

%disp(m);
% Plot graphic
h = figure;
filename = 'fixerend';
p=plot(solfinal,ReVar,"linewidth", 4);
xlabel('sigma');
ylabel('Re');
print(h, '-depsc2', filename);


%PARTIE 1.4

 m = mean(RR);
 rendSize = size(RR,1);
 RRc = RR(1:rendSize,1:10) - ones(rendSize,1)*m;
 Q = RRc' * RRc/rendSize;
 
 r = zeros(10,1);
 A = ones(10,1)';
 C = [-m;-eye(10)];
 
 solinit = zeros(10,1) ;
 solinit(4)= 1;
 tol = 1e-10;
 
 %ReVar = 0.0:0.002:0.041;
 
 solfinal2 = [];
 
 for d=-ReVar,
%  d = [d; zeros(10,1) ]; 
%  [sol,mult] = QPactivate(Q, r, A, C, d, solinit, tol)
%  solm = sqrt(sol'*Q*sol);
  %disp(solm);
%  solfinal2 = [solfinal2 solm];
 end;
 
 %disp(m);
 % Plot graphic
% $$$  h = figure;
% $$$  filename = 'parte14';
% $$$  p=plot(solfinal2,ReVar,"linewidth", 4);
% $$$  xlabel('sigma');
% $$$  ylabel('Re');
% $$$  print(h, '-depsc2', filename);

% $$$  
% $$$   h = figure;
% $$$   filename = 'compfixe';
% $$$   p=plot(solfinal2,ReVar,"linewidth", 4);
% $$$   hold all
% $$$   p=plot(solfinal,ReVar,"linewidth", 4);
% $$$   xlabel('sigma');
% $$$   ylabel('Re');
% $$$   print(h, '-depsc2', filename);
% $$$   disp(m);



%PARTIE PENTE

 m = mean(RR);
 rendSize = size(RR,1);
 RRc = RR(1:rendSize,1:10) - ones(rendSize,1)*m;
 Q = RRc' * RRc/rendSize;
 Q= 2*Q;
 r = zeros(10,1);
 A = (m'-0.02*ones(10,1))';

 C = [-m;-eye(10)];
 disp(ones(10,1));
 solinit = zeros(10,1) ;
 solinit(4)= 1;
 tol = 1e-10;

  disp(C*solinit);
 d = [zeros(11,1) ]; 
 
% [sol,mult] = QPactivate(Q, r, A, C, d, solinit, tol)
% solm = sqrt(sol'*Q*sol);
% disp(1/solm);
