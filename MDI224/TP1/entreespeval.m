% h = 0.5
% N =2

a=0;
b=5;
h=0.5; 
x1 = a:h:b;
s = sin(x1);
sp = cos(x1);

h2=h/2;
x2 = a:h2:b;
%x2=[pi];
y=speval(a,b,s,sp,x2,h)

h = figure; 
p=plot(x1,s,x2,y);
filename = 'sinus_2';
set(p,'LineWidth',4)
legend('sin','sin spline')
print(h, '-depsc2', filename);

% error sinus_2
h = figure; 
p = plot(x2,sin(x2)'-y);
filename = 'sinus_2_error';
set(p,'LineWidth',4)
legend('error spline')
print(h, '-depsc2', filename);

%  h = 0.5
 % N = 5
N=5;
a=0;
b=5;
h=0.5; 
x1 = a:h:b;
s = sin(x1);
sp = cos(x1);

h2=h/N;
x2 = a:h2:b;
%x2=[pi];
y=speval(a,b,s,sp,x2,h)

h = figure; 
p=plot(x1,s,x2,y);
filename = 'sinus_5';
set(p,'LineWidth',4)
legend('sin','sin spline')
print(h, '-depsc2', filename);

% error sinus_5
h = figure; 
p = plot(x2,sin(x2)'-y);
filename = 'sinus_5_error';
set(p,'LineWidth',4)
legend('error spline')
print(h, '-depsc2', filename);


%  h = 0.5
 % N = 10

a=0;
b=5;
h=0.5; 
x1 = a:h:b;
s = sin(x1);
sp = cos(x1);

h2=h/10;
x2 = a:h2:b;
%x2=[pi];
y=speval(a,b,s,sp,x2,h)

h = figure; 
p=plot(x1,s,x2,y);
filename = 'sinus_10';
set(p,'LineWidth',4)
legend('sin','sin spline')
print(h, '-depsc2', filename);

% error sinus_10
h = figure; 
p = plot(x2,sin(x2)'-y);
filename = 'sinus_10_error';
set(p,'LineWidth',4)
legend('error spline')
print(h, '-depsc2', filename);

%  h = 0.5
 % N = 2
N=2;
a=0;
b=5;
h=1; 
x1 = a:h:b;
s = exp(x1);
sp = exp(x1);

h2=h/N;
x2 = a:h2:b;
%x2=[pi];
y=speval(a,b,s,sp,x2,h)

h = figure; 
p=plot(x1,s,x2,y);
filename = 'exp_2';
set(p,'LineWidth',4)
legend('exp','exp spline')
print(h, '-depsc2', filename);

% error exp_2
h = figure; 
p = plot(x2,exp(x2)'-y);
filename = 'exp_2_error';
set(p,'LineWidth',4)
legend('error spline')
print(h, '-depsc2', filename);


%  h = 0.5
 % N = 5
N=5;
a=0;
b=5;
h=1; 
x1 = a:h:b;
s = exp(x1);
sp = exp(x1);

h2=h/N;
x2 = a:h2:b;
%x2=[pi];
y=speval(a,b,s,sp,x2,h)

h = figure; 
p=plot(x1,s,x2,y);
filename = 'exp_5';
set(p,'LineWidth',4)
legend('exp','exp spline')
print(h, '-depsc2', filename);


% error exp_5
h = figure; 
p = plot(x2,exp(x2)'-y);
filename = 'exp_5_error';
set(p,'LineWidth',4)
legend('error spline')
print(h, '-depsc2', filename);


%  h = 0.5
 % N = 5
N=10;
a=0;
b=5;
h=1; 
x1 = a:h:b;
s = exp(x1);
sp = exp(x1);

h2=h/N;
x2 = a:h2:b;
%x2=[pi];
y=speval(a,b,s,sp,x2,h)

h = figure; 
p=plot(x1,s,x2,y);
filename = 'exp_10';
set(p,'LineWidth',4)
legend('exp','exp spline')
print(h, '-depsc2', filename);



% error exp_10
h = figure; 
p = plot(x2,exp(x2)'-y);
filename = 'exp_10_error';
set(p,'LineWidth',4)
legend('error spline')
print(h, '-depsc2', filename);
