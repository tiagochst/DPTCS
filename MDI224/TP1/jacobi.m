% % % % % % % % % % % % % % % % % % %
% xx/12/11
% Chedraoui Silva,Tiago 
% Casier: 214 
% TP1: interpolation par splines cubiques
% Description: Methode jacobi 
% pour resoudre un systeme lineaire
% % % % % % % % % % % % % % % % % % %

function x = jacobi(A,b,x0,eps,maxit)

% Entree
% A : matrice
% b : vecteur
% x0: vecteur d'initialisation 
% esp: critere de convergence 
% maxit: nombre maximal d'iterations

% A in [N X N]
N = size(A);

% Iniatialization sortie
x = x0;

% Decomposition de A: 
% A = M - K
% M = D 
% K = L + U

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

  xn=D\(b-K*x(:,i));

  x=[x xn];
  
  % sauvegarder les valeurs pour faire
  % le plot log(erreur) X iteres 
  err=norm( x(:,i+1) - x(:,i) );
  
  % si l'erreur d'approximation est plus petite
  % que eps on doit arreter
  if (err <= eps) 
    break;
  end;
  
  % sinon je doit repeter l'iteration jusqu'a convergence

end;
