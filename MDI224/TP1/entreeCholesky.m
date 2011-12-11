N=5;
eps=1e-6;
maxiter=100;

A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);
p=2;
x = cholesky(A,p,b);

%printf('INPUT:\n');
%disp(A);
%disp(b);

printf('My result is:\n');
disp(x);

%section 3.3.2: complexite%

p=1; % p<<N
for N=50:50:300,
  
  A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
  A(1,1)=2; A(N,N)=2;
  xex = ones(N,1);
  b = A*xex;
  x0 = zeros(N,1);
  
  tic ();
  x = cholesky(A,p,b);
  elapsed_time = toc ();
  
  printf('CHOLESKY time for N = %d :\n',N);
  disp(elapsed_time);

end;  