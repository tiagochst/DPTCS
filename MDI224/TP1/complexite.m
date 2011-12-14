N=8;
A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);

% Donc:
D = diag(diag(A));
U = (-1)*triu(A,1);
L = (-1)*tril(A,-1);



disp('inv(D-L)\n');
disp(inv(D/1.1-L));
disp('-----------\n');


disp('inv(D-L)*U)\n');
%disp(inv(D-L)*U);
disp('-----------\n');

disp('inv(D)*(L+U)\n');
%disp(inv(D)*(L+U));
disp('-----------\n');