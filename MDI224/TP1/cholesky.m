function x = cholesky(A,p,b)

N = size(A,1);
L = zeros(N);
for i=1:N,
    L(i,i) = sqrt(A(i,i) - sum(L(i,max(1,i-p):i-1).^2));
    for j=i+1:min(i+p,N);
        L(j,i) = (A(i,j) - sum(L(i,max(1,j-p):i-1).*L(j,max(1,j-p):i-1))) / L(i,i);
    end;
end;
x = L'\(L\b);
