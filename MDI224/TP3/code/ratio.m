%PARTIE PENTE

 m = mean(RR);
 rendSize = size(RR,1);
 RRc = RR(1:rendSize,1:10) - ones(rendSize,1)*m;
 Q = RRc' * RRc/rendSize;
 Q= 2*Q; % la resolution est 1/2 x'Qx
 r = zeros(10,1);
 A = (m'-0.02*ones(10,1))';

 C = [-m;-eye(10)];
 disp(ones(10,1));
 solinit = zeros(10,1) ;
 solinit(4)= 1;
 tol = 1e-10;

  disp(C*solinit);
 d = [zeros(11,1) ]; 
 
 [sol,mult] = QPactivate(Q, r, A, C, d, solinit, tol)
 solm = sqrt(sol'*Q*sol);
 disp(1/solm);
