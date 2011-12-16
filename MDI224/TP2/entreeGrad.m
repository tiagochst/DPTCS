
N = 5; eps = 1e-6;
A = 4*eye(N) + diag(ones(1,N-1),1) + diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);

% 2.2.1
beta=0.01;
sol = mygradient(A,b,x0,beta,eps);
disp(sol);

sol = gradient_optimal(A,b,x0,eps);
disp(sol);


sol = gradient_conjugue(A,b,x0,eps);
disp(sol);