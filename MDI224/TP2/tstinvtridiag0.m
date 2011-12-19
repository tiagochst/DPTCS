%===== tstinvtridiag0.m
% Calcul de spline cubique naturelle
clear
global t t2 t3
Npts=100; t=[0:Npts-1].'/Npts; t2=t.*t; t3=t2.*t;
figure(1)
plot([-1;1],[-1;1],'w'); grid
Pk=acqPk; N=length(Pk);
hold on; plot(real(Pk),imag(Pk),'o',real(Pk),imag(Pk),'-'); hold off

% Suite des derivees secondes
% Iniatialization matrice A (Ax=b)
A = 4*eye(N-2) + diag(ones(1,N-3),1) + diag(ones(1,N-3),-1);
A = A/6;
x0 = zeros(N-2,1);
b=toeplitz(Pk(3:N),[Pk(3) Pk(2) Pk(1)])*[1;-2;1];
sol = gradient_conjugue(A,b,x0,10e-6);

% on doit prendre la derniere colonne de la matrice sol
dsec = sol(:,size(sol,2));

% la premiere et la dernier derive seconde sont 0
dsec = [0;dsec;0];

% Calcul des segments (utiliser global t, t2 et t3)
% ...
Skt=[];
for k=1:N-1
Pkt=spline3(Pk(k),Pk(k+1),dsec(k),dsec(k+1));
Skt=[Skt;Pkt];
end
hold on; plot(Skt); hold off