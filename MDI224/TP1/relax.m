% % % % % % % % % % % % % % % % % % %
% 12/12/11
% Chedraoui Silva,Tiago 
% Casier: 214 
% TP1: interpolation par splines cubiques
% Description: Methode relaxation 
% pour resoudre un systeme lineaire
% % % % % % % % % % % % % % % % % % %

function x = relax(A,b,x0,w,eps,maxit)

% Entree
% A : matrice
% b : vecteur
% x0: vecteur d'initialisation
% w : parametre de relaxation 
% esp: critere de convergence 
% maxit: nombre maximal d'iterations

% A in [N X N]
N = size(A);

% Iniatialization sortie
x = x0;

% Decomposition de A: 
% A = M - K
% M = D/w - L 
% K = (1-w)D/w + U

% Pour rappeler:
% ----------
% | d -u -u|
% |-l  d -u|
% |-l -l  d|
% ----------

% Donc:
D = diag(diag(A));
U = (-1)*triu(A,1);
L = (-1)*tril(A,-1);

% Obs: Le deuxieme valeur de triu et tril
% est utilise por mettre des zeros au 
% lieu de la diagonal principal

M = D/w - L;
K = (1.0-w)*D/w + U;

for i=1:maxit,

  xn=M\((K*x)+b);

  % sauvegarder les valeurs pour faire
  % le plot log(erreur) X iteres 
  err=norm( x - xn );
  
  %log_y(i)=log(err);
  
  % si l'erreur d'approximation est plus petite
  % que eps on doit arreter
  if (err <= eps) 
    printf('Nombre iterations: %d\n',i);
    break;
  end;
  
  % sinon je doit repeter l'iteration jusqu'a convergence
  x=xn;
end;

% Plot graphic
%h = figure; 
%filename = 'relaxation_graph';
%p=plot(log_y);
%xlabel('Iteres');
%ylabel('log(erreur)');
%set(p,'Color','blue','LineWidth',4)
%print(h, '-depsc2', filename);

%printf('=== Taux de convergence pour %f ===\n',w);
%p = polyfit([1:i],log_y,1);
%printf('p(x)= %f x + %f \n',p(1),p(2));
%printf('============================\n');
