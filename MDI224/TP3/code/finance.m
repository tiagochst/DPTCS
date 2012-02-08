% Marche 1

% On va lire le fichier RR.txt
% Pour faciliter (On a effacer le tete du fichier)
load RR.txt

%redement( RR, nActives,ReVar );
ReVar = 0.0:0.00025:0.1;
sigma = redement( RR, 10,ReVar  );
sigma3 = redement( RR, 3,ReVar  );
sigma5 = redement( RR, 5,ReVar  );

% Plot graphic
h = figure;
filename = 'redment10';
p=plot(sigma,ReVar,"linewidth", 4);
hold all
p=plot(sigma5,ReVar,"linewidth", 4);
hold all
p=plot(sigma3,ReVar,"linewidth", 4 );
hleg1 = legend('10','5','3');
xlabel('sigma');
ylabel('Re');
print(h, '-depsc2', filename);



%PARTIE 1.3.52=========================================================
ReVar = 0.0:0.00025:0.025;
[ sigmaRho1,sigmaRho2,sigmaRho3 ] = rendCov( RR, 2,ReVar);

% Plot graphic
h = figure;
filename = 'rho';
p=plot(sigmaRho1,ReVar,"linewidth", 4);
hold all
p=plot(sigmaRho2,ReVar,"linewidth", 4);
hold all
p=plot(sigmaRho3,ReVar,"linewidth", 4);
hleg1 = legend('-0.9','0','0.9');
xlabel('sigma');
ylabel('Re');
print(h, '-depsc2', filename);
