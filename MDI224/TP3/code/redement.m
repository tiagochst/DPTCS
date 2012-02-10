function [ sigma ] = redement( RR, nActives, ReVar )

m = mean(RR);
m = m(1,1:nActives);
rendSize = size(RR,1);
RRc = RR(1:rendSize,1:nActives) - ones(rendSize,1)*m;
Q = RRc' * RRc/rendSize;

u = ones(nActives,1);

A = u'*inv(Q)*u;
B = u'*inv(Q)*m'; 
D = m*inv(Q)*m';
delta = A*D-B*B;
limRe = B/A;

sigma=[];

for Re=ReVar,

  lambda = (D-Re*B)/delta;
  mi = (-B+A*Re)/delta;

  xe = inv(Q)*(lambda*u + mi*m');

  if (Re<B/A)
    sigmaRes = 1/sqrt(A);
  else
    sigmaRes = sqrt(xe'*Q*xe);
  end;
  
  sigma = [sigma sigmaRes ];
  
end;

end

