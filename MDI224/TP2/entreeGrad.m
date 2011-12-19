
N = 5; eps = 1e-6;
A = 4*eye(N) + diag(ones(1,N-1),1) + diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);

% 2.2.1
beta=0.01;
sol = mygradient(A,b,x0,beta,eps);

disp('GRAD')
disp('ITER')
disp(size(sol,2)-1);
disp('sol grad')
disp(sol(:,size(sol,2)));

% b

% quel est le plus grande valeur propre de la matrice A
lambda1 = max(abs(eig(A)));
disp('le plus grande valeur propre de la matrice A');
disp(lambda1);


% Trouver le meilleur Beta
l=1;
maxVar=2/lambda1
betaVar=0.01:0.1:maxVar;
%betaVar=[betaVar maxVar-0.0001];

disp('betaVar');

for beta=betaVar,
 
  x =  mygradient(A,b,x0,beta,eps);

  eb=[];
  for i=1:size(x,2),
    eb(i)=norm(x(:,i)-xex);
  end;
 
  log_y=log(eb);

  p = polyfit([1:i],log_y,1);
  by(l)=p(1);
  l=l+1;
 
end;

by = exp(by);

%h = figure; 
%filename = 'grad_beta';
%p=plot(betaVar,by);
%xlabel('Beta');
%ylabel('Taux de convergence');
%set(p,'Color','blue','LineWidth',4)
%print(h, '-depsc2', filename);

%%
%2.2.2
%%
tic ();
sol = gradient_optimal(A,b,x0,eps);
elapsed_time = toc ();

printf('GRAD OPT time :\n');
disp(elapsed_time);

disp('GRAD OPT')
disp('ITER')
disp(size(sol,2)-1);
disp('sol grad')
disp(sol(:,size(sol,2)));


% Error plot graphic
N2=size(sol);
for i=1:N2(2),
  e(i)=norm(sol(:,i)-xex);
end;

y=log(e);

%h = figure; 
%filename = 'grad_optimal';
%p=plot(y);
%xlabel('Iteres');
%ylabel('log(erreur)');
%set(p,'Color','blue','LineWidth',4)
%print(h, '-depsc2', filename);

printf('=== GRAD OPT: Taux de convergence ===\n');
p = polyfit([1:i],y,1);
printf('p(x)= %f x + %f \n',p(1),p(2));
printf('============================\n');

%%
%2.2.3
%%
N = 5; eps = 1e-6;
A = 4*eye(N) + diag(ones(1,N-1),1) + diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);


tic ();
sol = gradient_conjugue(A,b,x0,eps);
elapsed_time = toc ();

printf('GRAD CONJ time :\n');
disp(elapsed_time);


disp('GRAD CONJ')
disp('ITER')
disp((size(sol,2)-2));
disp('sol grad')
disp(sol(:,size(sol,2)));


%%
%2.2.3 d
%%

tic ();
sol = relax(A,b,x0,1,eps,100);
elapsed_time = toc ();

printf('RELAX time :\n');
disp(elapsed_time);


disp('RELAX')
disp('ITER')
disp(size(sol,2)-1);
disp('sol RELAX')
disp(sol(:,size(sol,2)));


%%
% section 3
%%
%%
% To do: dessiner, resoudre le systeme Ax=b pour x
%%

% Iniatialization matrice A (Ax=b)
A = 4*eye(N) + diag(ones(1,N-1),1) + diag(ones(1,N-1),-1);
A = A/6;

% Iniatialization vecteur b (Ax=b)
%Pk=acqPk();
%b=toeplitz(Pk(3:N),[Pk(3) Pk(2) Pk(1)])*[1;-2;1]
%disp(b);