% Marche 1

% On va lire le fichier RR.txt 
% Pour faciliter (On a effacer le tete du fichier)
fid = fopen('data/RR.txt','r');

% nous avons 10 actifs dans le marche 1
nrend = 10;

M = fscanf(fid,'%f %f %f %f %f %f %f %f %f %f ',[nrend Inf]);
M1 = M';


for aux=1:nrend,
  if(aux==1)
    m1 = mean(M1(:,aux));
  else
    m1 = [m1 mean(M1(:,aux))];
  end;
end;

disp(m1);

Q1 = cov(M); 
disp(Q1);


disp('Marche 2');
sp500 = load('data/sp500em') ;

% Seulement les donnes de S&P500 Index?
%disp(sp500.names(506,:));
%disp(size(sp500.dates));
%disp(sp500.prices(:,506));

% formule  R_{j,\tau} = -1 + \frac{(B_j{j+1}}{B_j)}^\tau

maxiter = (size(sp500.dates,1)-2);

for aux = 1:maxiter,

  if(aux==1)
    R = -1 +  (sp500.prices(aux+1,506)/sp500.prices(aux,506))^(sp500.dates(aux+1)-sp500.dates(aux));
  else
    Raux = -1 +  (sp500.prices(aux+1,506)/sp500.prices(aux,506))^(sp500.dates(aux+1)-sp500.dates(aux));
    R = [R Raux];
  end;
end;

%disp(R);

% faire le calcule de R
 Q2 = cov(R);
 m2 = mean(R);

disp(Q2);
disp(m2);
