% % % % % % % % % % % % % % % % % % %
% 19/12/11
% Chedraoui Silva,Tiago 
% Casier: 214 
% CLERBOUT, Anthony
% Casier: 234 
% TP2: interpolation par splines 
% cubiques partie II
% Description: Gradient a pas constant
% % % % % % % % % % % % % % % % % % %

function x = gradient_optimal(A,b,x0,eps)

% Entree
% A : matrice
% b : vecteur
% x0: vecteur d'initialisation 
% esp: critere de convergence 

xn=[1 3 2 0 1]'; % rand vector
x=x0;
x=[x xn];
i=1;

while (norm (x(:,i+1) - x(:,i))>eps),
  
  %  Pour la  fonction
  %    J=1/2*xT*A*x-xTb;
  %  Le gradient est donne par
  %    g=Ax-b;
  
  g = A*xn-b;
  
  beta = g'*g/(g'*A*g);
  
  xn = x(:,i+1)-beta*g;
  x = [x xn];
  i++;
 
end;
