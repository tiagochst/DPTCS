% % % % % % % % % % % % % % % % % % %
% 12/12/11
% Chedraoui Silva,Tiago 
% Casier: 214 
% Anthony CLERBOUT
% Casier: 234 
% TP1: interpolation par splines cubiques
% Description: evaluer une fonction spline 
% cubique aux points donnes par x
% % % % % % % % % % % % % % % % % % %

function y = speval(a,b,s,sp,x,h)

% Entree
% [a,b] : valeurs intervale 
% s : valeurs splines 
% sp :valeurs derive premier
% x :vecteur de points a value la fonction
% h: pas interaction

% Sortie

% x in [N X 1]
N = size(x,2);
N2 = size(s,2);

% Sortie
y =  zeros(N,1);

% Theorique: Poly page 28/43
% P(i)= diff1*L+diff2*M
% diff1= (t-t_i+1)^2/(h*h)
% diff2= (t-t_i)^2/(h*h)
% L = (s_i+(s_i' + 2 s_i/h)(t-t_i))
% M = (s_{i+1}+(s_{i+1}' - 2 s_{i+1}/h)(t-t_{i+1}))

for j=1:N,

  % Quel points sont les plus proches duquel je voudrais calculer?
  % t1 et t2 vont donner le index du vecteur 
  % t11 et t22 vont donner les valeur temporel plus proche
  t1=1;
  t2=2;
  t11=a;
  t22=a+h;
 
  for k=1:N2-1,
    if(x(j)>(b-k*h))
      t1=N2-k;
      t2=N2-k+1;
      t11=b-k*h;
      t22=b+h*(1-k);
      break;
    end;
  end;
  
  diff1 = ((x(j)-t22)^2)/(h*h);
  diff2 = ((x(j)-t11)^2)/(h*h);
  L = (s(t1))+((sp(t1)+2*s(t1)/h)*(x(j)-t11));
  M = (s(t2))+((sp(t2)-2*s(t2)/h)*(x(j)-t22));
  
  y(j)= diff1*L+diff2*M;

end;
