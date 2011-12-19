function [Pk]=acqPk
%!==========================================!
%! Acquisition des points d'une trajectoire !
%! SYNOPSIS: Pk=acqPk                       !
%! Pk suite complexe des points             !
%!==========================================!
title('Taper en dehors du rectangle pour terminer')
x=[]; y=x;
hold on; ifini=false; k=1;
while ~(ifini)
    [a,b]=ginput(1); 
    if (abs(a)>1 | abs(b)>1), 
       ifini=true;
    else
       x=[x a]; y=[y b]; plot(a,b,'o');
    end
    k=k+1;
end
Pk=x+1j*y; 
hold off
