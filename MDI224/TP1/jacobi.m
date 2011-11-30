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

% Sortie
x =  zeros(N);

% Iniatialization sortie
x = x0;

% Decomposition de A: 
% A = M - K
% M = D 
% K = L + U

% creation de matrices N X N
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

  % sauvegarder les valeurs pour faire
  % le plot log(erreur) X iteres 
  err=norm( x - xn );
  
  y(i)=log(err); 
  
  % si l'erreur d'approximation est plus petite
  % que eps on doit arreter
  if (err < eps) 
    printf('Nombre iterations: %d\n',i);
    break;
  end;
  
  % sinon je doit repeter l'iteration jusqu'a convergence
  x = xn;

end;

% Plot graphic
h = figure; 
filename = 'jacobi_graph';
plot(y);
xlabel('Iteres');
ylabel('log(erreur)');
print(h, '-depsc2', filename);