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

  xn=D\(b-K*x);

  % sauvegarder les valeurs pour faire
  % le plot log(erreur) X iteres 
  err=norm( x - xn );
  
  %y(i)=log(err); 
  
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
%h = figure; 
%filename = 'jacobi_graph';
%p=plot(y);
%xlabel('Iteres');
%ylabel('log(erreur)');
%set(p,'Color','blue','LineWidth',4)
%print(h, '-depsc2', filename);

%printf('=== Taux de convergence ===\n');
%p = polyfit([1:i],y,1);
%printf('p(x)= %f x + %f \n',p(1),p(2));
%printf('============================\n');
