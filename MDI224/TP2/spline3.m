function Pkt=spline3(Pk,Pkp1,dSk,dSkp1);
%!==========================================!
%! SYNOPSIS: Pkt=SPLINE3(Pk,Pkp1,dSk,dSkp1) !
%! Pk,Pkp1     = extremites segments        !
%! dSk,dSkp1 = derivees secondes aux        !
%!               extremites                 !
%!==========================================!
%! global t,t2,t3: vecteurs t, t^2, t^3 du  !
%! parametre t=[0:N-1]'/N;                  !
%%==========================================!
global t t2 t3
Pkt=(dSkp1-dSk)*t3/6 + dSk*t2/2 + (Pkp1-Pk-dSk/3-dSkp1/6)*t + Pk;
return
