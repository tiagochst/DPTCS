% % % % % % % % % % % % % % % % % % %
% xx/12/11
% Chedraoui Silva,Tiago 
% Casier: 214 
% TP1: interpolation par splines cubiques
% Description: Calculer la spline cubique 
% d'interpolation
% % % % % % % % % % % % % % % % % % %

function sp = sinterp(y)

% Entree
% y : vecteur

% y in [N X 1]
N = size(y,1);

% Sortie
sp =  zeros(N);

disp(N);
disp(sp);

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

% cas donné par C3
b(N)=y(N)-y(N-1);
b(1)=y(2)-y(1);

for i=2:N-1, 
  b(i)=y(i+1)-y(i-1);
end; 

% Soit h egal a 1
h=1;
b=(3/h)*b;

printf('== Matrice A ==\n');
disp(A);
printf('== vecteur b ==\n');
disp(b);

sp=inv(A)*(b);
disp(sp);

end;
