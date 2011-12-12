N=5;
eps=1e-6;
maxiter=100;

A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);
x = jacobi(A,b,x0,eps,maxiter);

printf('My result is:\n');
%disp(x);

N2=size(x);
printf('My size:\n');
disp(N2);

for i=1:N2(2),
  e(i)=norm(x(:,i)-xex);
end;

y=log(e);

% Plot graphic
h = figure; 
filename = 'jacobi_graph';
p=plot(y);
xlabel('Iteres');
ylabel('log(erreur)');
set(p,'Color','blue','LineWidth',4)
print(h, '-depsc2', filename);

printf('=== Taux de convergence ===\n');
p = polyfit([1:i],y,1);
printf('p(x)= %f x + %f \n',p(1),p(2));
printf('============================\n');

%section 3.3.2: complexite%

for N=50:50:300,
  
  A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
  A(1,1)=2; A(N,N)=2;
  xex = ones(N,1);
  b = A*xex;
  x0 = zeros(N,1);
  
  tic ();
  x = jacobi(A,b,x0,eps,maxiter);
  elapsed_time = toc ();
  
  printf('Jacobi time for N = %d :\n',N);
  disp(elapsed_time);

end;  