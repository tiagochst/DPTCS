% % % % % % % % % % % % % % % % % % % % % % %
% xx/12/11
% Chedraoui Silva,Tiago 
% Casier: 214 
% TP1: interpolation par splines cubiques
% Description: Méthode jacobi pour résoudre 
%   un système linéaire
% % % % % % % % % % % % % % % % % % % % % % %

function x = jacobi(A,b,x0,eps,maxit)

% Entrée
% A : matrice
% b : vecteur
% x0: vecteur d'initialisation 
% esp: critère de convergence 
% maxit: nombre maximal d'itérations

% A in [N X N]
N = size(A);

% Sortie
x =  zeros(N);
x = x0;


% Décomposition de A: 
% A = M - K
% M = D 
% K = L + U

% création de matrices N X N
K = zeros(N);
D = zeros(N);

% Pour rappeler:
% ----------
% | d -u -u|
% |-l  d -u|
% |-l -l  d|
% ----------
% Donc:
D = diag(diag(A));
K = A-D;

for i=1:maxit,

  xn=inv(D)*(b-K*x);

  % si l'erreur d'approximation est plus petitr
  % que eps on doit arrêter
  if (norm( x - xn ) < eps) 
    printf('Nombre itérations: %d\n',i);
    break;
  end;
  
  %sinon je doit répéter l'itération jusqu'à convergence
  x = xn;
  
end;
