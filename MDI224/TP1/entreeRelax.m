N=5;
eps=1e-6;
maxiter=100;
w=1.0;

A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);

x = relax(A,b,x0,w,eps,maxiter);

printf('My result is:\n');
disp(x);

N2=size(x);

for i=1:N2(2),
  e(i)=norm(x(:,i)-xex);
end;

y=log(e);

% Plot graphic
h = figure; 
filename = 'relaxation_graph';
p=plot(y);
xlabel('Iteres');
ylabel('log(erreur)');
set(p,'Color','blue','LineWidth',4)
print(h, '-depsc2', filename);

% Display polyfot of log(err)
printf('=== Taux de convergence pour %f ===\n',w);
p = polyfit([1:i],y,1);
printf('p(x)= %f x + %f \n',p(1),p(2));
printf('============================\n');


% Trouver le meilleur w
l=1;
for w=0.01:0.1:1.9,
  
  x = relax(A,b,x0,w,eps,maxiter);

  N2=size(x);

  ew=[];
  for i=1:N2(2),
    ew(i)=norm(x(:,i)-xex);
  end;
 
  log_y=log(ew);

  p= polyfit([1:i],log_y,1);
  wy(l)=p(1);
  l=l+1;

end;

x = relax(A,b,x0,1.99,eps,maxiter);

N2=size(x);

ew=[];
for i=1:N2(2),
  ew(i)=norm(x(:,i)-xex);
end;

log_y=log(ew);

p= polyfit([1:i],log_y,1);
wy(l)=p(1);
l=l+1;


wy=exp(wy);
wx=[0.01:0.1:1.9];
wx=[wx 1.99];


% Plot conv graphic
h = figure; 
filename = 'relaxation_conv2';
p=plot(wx,wy);
xlabel('Omega');
ylabel('Taux de convergence');
set(p,'Color','blue','LineWidth',4)
print(h, '-depsc2', filename);

%section 3.3.2: complexite%

w=1.1;
for N=50:50:300,
  
  A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
  A(1,1)=2; A(N,N)=2;
  xex = ones(N,1);
  b = A*xex;
  x0 = zeros(N,1);
  
  tic ();
  x = relax(A,b,x0,w,eps,maxiter);
  elapsed_time = toc ();
  
  printf('Relax time for N = %d :\n',N);
  disp(elapsed_time);

end;  

