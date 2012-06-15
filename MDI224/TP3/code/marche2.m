% marche 2
sp506=load('sp500em') ;

nactives = size(sp506.prices,2); 
ndata = size(sp506.prices,1);

RR2 = zeros(ndata,nactives-1);
for aux2=1:1:nactives,
  for aux1=1:1:ndata-1,
    if(sp506.prices(aux1,aux2) ~= 0)
      if((sp506.prices(aux1+1,aux2)/sp506.prices(aux1,aux2)) < 0)
	RR2(aux1,aux2)= -1 -abs((sp506.prices(aux1+1,aux2)/sp506.prices(aux1,aux2)))^(1/(sp506.dates(aux1+1) - sp506.dates(aux1)));
      else
	RR2(aux1,aux2)= -1 +(sp506.prices(aux1+1,aux2)/sp506.prices(aux1,aux2))^(1/(sp506.dates(aux1+1) - sp506.dates(aux1)));
      end
    else
      RR2(aux1,aux2) = 0;
    end
  end
end

m = mean (RR2);
disp(size(m));
rendSize = size (RR2 ,1) ;
disp(size(RR2));
RRc = RR2 - ones(rendSize,1)*m;
Q = RRc' * RRc/rendSize;
u = ones(nactives,1);

r = zeros(nactives,1);
A = ones(nactives,1)';
C = [-m;-eye(nactives)];

solinit = zeros(nactives,1) ;
solinit(7)= 1;
tol = 1e-10;
ReVar = 0.0:0.001:0.001;
solfinal2 = [];
disp(m);
for d=-ReVar,
  disp(d);
  d = [d; zeros(nactives,1) ]; 
  [sol,mult] = QPactivate(Q, r, A, C, d, solinit, tol);
  solm = sqrt(sol'*Q*sol);
  solfinal2 = [solfinal2 solm];
end;

% Plot graphic
h = figure;
filename = 'marche2';
p=plot(solfinal2,ReVar,"linewidth", 4);
xlabel('sigma');
ylabel('Re');
print(h, '-depsc2', filename);
