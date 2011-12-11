N=5;
eps=1e-6;
maxiter=100;
w=1.0;

A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
A(1,1)=2; A(N,N)=2;
xex = ones(N,1);
b = A*xex;
x0 = zeros(N,1);

%for w=0.1:0.1:2
  x = relax(A,b,x0,w,eps,maxiter);
%end

printf('My result is:\n');
disp(x);

wx=[0.0:0.1:2];
wy=[ -0.000150; -0.118230 ;-0.191228 ;-0.278141 ;-0.369919 
     -0.465960 ;-0.560344 ;-0.674184 ;-0.812304 
     -1.015682 ;-1.380155 ;-2.007046 ;-1.469264
     -1.191068 ;-0.918860 ;-0.688261 ;-0.507122
     -0.358010 ;-0.223573 ;-0.105267 ; 0.000049 ];


% Plot conv graphic
%h = figure; 
%filename = 'relaxation_conv';
%p=plot(wx,exp(wy));
%xlabel('Omega');
%ylabel('Taux de convergence');
%set(p,'Color','blue','LineWidth',4)
%print(h, '-depsc2', filename);

%section 3.3.2: complexite%

w=1.1;
for N=50:50:300,
  
  A=4*eye(N) + diag(ones(1,N-1),1) +  diag(ones(1,N-1),-1);
  A(1,1)=2; A(N,N)=2;
  xex = ones(N,1);
  b = A*xex;
  x0 = zeros(N,1);
  
  tic ();
  x = relax(A,b,x0,w,eps,maxiter);
  elapsed_time = toc ();
  
  printf('Relax time for N = %d :\n',N);
  disp(elapsed_time);

end;  

