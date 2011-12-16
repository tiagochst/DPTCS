% % % % % % % % % % % % % % % % % % %
% 19/01/11
% Chedraoui Silva,Tiago 
% Casier: 214 
% CLERBOUT, Anthony
% Casier: 234 
% TP2: interpolation par splines 
% cubiques partie II
% Description: Gradient a pas constant
% % % % % % % % % % % % % % % % % % %

function x = mygradient(A,b,x0,beta,eps)

% Entree
% A : matrice
% b : vecteur
% x0: vecteur d'initialisation 
% beta: le pas 
% esp: critere de convergence 

xn=x0;
x=[x0 xn];
i=1;

while (norm (x(:,i+1) - x(:,i))>eps || i==1 ),
  
  %  Pour la  fonction
  %    J=1/2*xT*A*x-xTb;
  %  Le gradient est donne par
  %    g=Ax-b;
  
  g = A*xn-b;
 
  xn = x(:,i+1)-beta*g;
  x = [x xn];
  i++;
 
end;
