function [ sigmaRho1,sigmaRho2,sigmaRho3 ] = rendCov( RR, nActives, ReVar )
%RENDCOV Summary of this function goes here
%   Detailed explanation goes here

m = mean(RR);
m = m(1,1:nActives);
rendSize = size(RR,1);

RRc = RR(1:rendSize,1:nActives) - ones(rendSize,1)*m;
Q = RRc' * RRc/rendSize;
u = ones(nActives,1);

RhoVar = -0.9:0.9:0.9;

sigma1 = sqrt(Q(1,1));
sigma2 = sqrt(Q(2,2));

for Rho=RhoVar,

    Q = [sigma1*sigma1 Rho*sigma1*sigma2 ; Rho*sigma1*sigma2 sigma2*sigma2];
    A = u'*inv(Q)*u;
    B = u'*inv(Q)*m'; 
    D = m*inv(Q)*m';
    delta = A*D-B*B;
    limRe = B/A;

    sigmaRho=[];
   
    for Re=ReVar,

        lambda = (D-Re*B)/delta;
        mi = (-B+A*Re)/delta;

        xe = inv(Q)*(lambda*u + mi*m');

        if (Re<=B/A)
            sigmaRes = 1/sqrt(A);
        else
            sigmaRes = sqrt(xe'*Q*xe);
        end;
  
        sigmaRho = [sigmaRho sigmaRes ];
    end;
        
    switch Rho
    case -0.9
      sigmaRho1 = sigmaRho ;
    case 0
        sigmaRho2 = sigmaRho ;
    case 0.9
        sigmaRho3 = sigmaRho ;
    end
  
  % sinon je doit repeter l'iteration jusqu'a convergence

end;

end

