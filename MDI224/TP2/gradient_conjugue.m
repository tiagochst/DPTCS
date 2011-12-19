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

function x = gradient_conjugue(A,b,x0,eps)

xn = x0;
x = [x0 xn];
i = 1;

g = A*xn-b;
w = g;

while (norm (x(:,i+1) - x(:,i))>eps || i==1),
  
  beta = g'*w/(w'*A*w);

  xn = x(:,i+1)-beta*w;
  x = [x xn];
  
  g = A*xn-b;
  a = -g'*A*w/(w'*A*w);
  w=g+a*w;

  i++;
  
end