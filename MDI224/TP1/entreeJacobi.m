N=5;
eps=1e-6;
maxiter=100;

A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);
x = jacobi(A,b,x0,eps,maxiter);

%printf('INPUT:\n');
%disp(A);
%disp(b);

printf('My result is:\n');
disp(x);

%eps=0.001;
%maxiter=100;
%A = [5.02 2.01 -0.98; 3.03 6.95 3.04; 1.01 -3.99 5.98];
%b = [2.05 -1.02 0.98]';     
%x0 = [0.49807, -0.30502, -0.11969]';
%x = jacobi(A,b,x0,eps,maxiter);

%printf('INPUT:\n');
%disp(A);
%disp(b);

%printf('My result is:\n');
%disp(x);
