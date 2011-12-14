% % % % % % % % % % % % % % % % % % %
% 12/12/11
% Chedraoui Silva,Tiago 
% Casier: 214 
% Anthony CLERBOUT
% Casier: 234 
% TP1: interpolation par splines cubiques
% Description: Calculer la spline cubique 
% d'interpolation
% % % % % % % % % % % % % % % % % % %

function sp = sinterp(y,h)

% Entree
% y : vecteur

% y in [N X 1]
N = size(y,2);

% Sortie
%sp =  zeros(N);

%disp(N);
%disp(sp);

% Iniatialization matrice A (Ax=b)
A = zeros(N,N);
A(1,1)=2; A(N,N)=2;
A(1,2)=1; A(N,N-1)=1;

for i=2:N-1, 
  A(i,i-1)=1;
  A(i,i)=4;
  A(i,i+1)=1;
end;

% Iniatialization vecteur b (Ax=b)
b = zeros(N,1);

% cas donne par C3

% s(n) - s(n-1)
b(N)=y(N)-y(N-1); 

% s2-s1
b(1)=y(2)-y(1);

%
for i=2:N-1, 
  b(i)=y(i+1)-y(i-1);
end; 

b=(3/h)*b;


sp2=A\(b);
[sp2,rho] = relax(A,b,sp2,1,1e-6,100);

sp= sp2(:,(size(sp2,2)));
end;
