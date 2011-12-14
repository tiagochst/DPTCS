% h = 0.5
% N =2

a=0;
b=5;
h=0.5; 
x1 = a:h:b;
s = sin(x1);

sp = sinterp(s,h);

h2=h/2;
x2 = a:h2:b;
%x2=[pi];
y=speval(a,b,s,sp,x2,h)

h = figure; 
p=plot(x1,s,x2,y);
filename = 'teste_sinus_2';
set(p,'LineWidth',4)
legend('sin','sin spline')
print(h, '-depsc2', filename);

% error sinus_2
h = figure; 
p = plot(x2,sin(x2)'-y);
filename = 'teste_sinus_2_error';
set(p,'LineWidth',4)
legend('error spline')
print(h, '-depsc2', filename);


% h = 0.5
% N =2

a=0;
b=5;
h=0.05; 
x1 = a:h:b;
s = sin(x1);

sp = sinterp(s,h);

h2=h/10;
x2 = a:h2:b;
%x2=[pi];
y=speval(a,b,s,sp,x2,h)

h = figure; 
p=plot(x1,s,x2,y);
filename = 'teste_sinus_10_2';
set(p,'LineWidth',4)
legend('sin','sin spline')
print(h, '-depsc2', filename);

% error sinus_2
h = figure; 
p = plot(x2,sin(x2)'-y);
filename = 'teste_sinus_10_error_2';
set(p,'LineWidth',4)
legend('error spline')
print(h, '-depsc2', filename);
