function [sol,mult] = ...
    QPactivate(Q, r, A, C, d, solinit, tol)
%===============================================
% synopsis
%   [sol,mult] = ...
%      QPactivate(Q, r, A, C, d, solinit, tol)
%    
% QPactivate solves the quadratic problem
% Min (1/2) x'Q x-r'x 
%       s.c. A x = b, C x =< d
% Methode d'activation des contraintes.
%
% Q : matrice positive de dimension n x n
% r : vecteur de dimension n x 1
% A : matrice de dimension p x n
% C : matrice de dimension q x n
% d : vecteur de dimension q x 1
% solinit : valeur faisable cad satisfaisant 
% les contraintes d'egalites (CE) Ax=b
% et les contraintes d'inegalites (CI) Cx=<d
% Par conséquent A * solinit = b
% (et donc b est passe de façon implicite)
%===============
% sol : solution
% mult : multiplicateurs de lagrange
%        lambda=mult(1:p)
%        mu=mult(p+1:p+q)
%================================================
% initialisation du point courant
sol=solinit;
ecartInegalites=C*sol-d;
% sol doit etre un point faisable.
% pour cela il faut qu'il verifie 
% A * sol = b (ce qui définit b)
% et 
% C * sol - d <=0
% 
if any(ecartInegalites>0)
    error('Initialisation non admissible');
end;
if isempty(A), 
    p=0;
else
    p=length(A(:,1));
end;
% drapeaux donnant les contraintes d'inegalites (CI)
% (presque) actives (ou saturees)
activate=abs(ecartInegalites) < tol; 
boucleextnotfini=1;
while boucleextnotfini     % boucle exterieure
    boucleintnotfini=1;
    while boucleintnotfini % boucle interieure
        % matrice des contraintes d'egalite
        S=[A;diag(activate)*C];
        % matrice nulle associee, cad base du noyau
        Z=null(S);
        % on sort de la boucle interieure
        % cas trivial ou x_{k+1}=x_k+0
        if isempty(Z), break; end;
        % Sinon
        % x_{k+1}=x_k+v ou v=Zu et
        % ou u est solution du systeme KKT reduit
        % v represente l'ecart sur x
        v=Z*(Z'*Q*Z\Z'*(r-Q*sol));
        % Si deplacement non significatif
        % on sort de la boucle interieure
        if norm(v,inf)<=tol, break; end;
        % w represente l'ecart sur Cx-d
        w=C*v;
        % on cherche les indices tels que
        % ecartmax=w+ecartInegalites devient
        % positif
        J=find(w+ecartInegalites>tol);
        % J tel que w est positif
        % calcul du pas
        if isempty(J),
            % si toutes les contraintes sont quasi
            % actives
            t=1;
            boucleintnotfini=0;
        else
            % sinon on deplace le point courant
            % avec le pas assurant que toutes les 
            % composantes restent negaitves.
            % noter que ecartInegalites<0 et 
            % que w(J)>=0, donc 
            % -(ecartInegalites(J)./ w(J))>=0
            % et plus petit que 1 
            % car w(J) > -ecartInegalites
            t=-max(ecartInegalites(J)./ w(J));
        end;
        % actualisation du point courant
        sol=sol+t*v;
        % actualisation de l'ecart des CI
        ecartInegalites=ecartInegalites+t*w;
        % actualisation des contraintes activees
        activate=abs(ecartInegalites)<tol;
        % deplacement maximum: on sort de la
        % boucle interieure
    end;
    % calcul des multiplicateurs de Lagrange
    % cad les lambda des CE et les mu des CI dites
    % actives, les mu des CI non staurees valant 0
    % (solution au sens des moindres carres)
    mult=pinv(S')* (r-Q*sol); 
    if any(mult(p+1:end)<-tol),
        [mu, jmumin]=min(mult(p+1:end));
        activate(jmumin)=0; % mise a jour du drapeau
    else
        boucleextnotfini=0; % la solution est trouvee
    end;
end;
sol=sol/sum(sol);