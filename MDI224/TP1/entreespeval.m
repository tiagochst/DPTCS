a=0;
b=5*pi;
x1 = a:0.5:b;
s = sin(x1);
sp = cos(x1);

x2 = a:0.5:b;
%x2=[pi];
y=speval(a,b,s,sp,x2)

h = figure; 
p=plot(x1,s);
% hold axes and all lineseries properties, such as
% ColorOrder and LineStyleOrder, for the next plot
filename = 'speval_sin';
set(p,'Color','blue','LineWidth',4)
print(h, '-depsc2', filename);

h = figure; 
p=plot(x2,y);
filename = 'speval_sininter';
set(p,'Color','blue','LineWidth',4)
print(h, '-depsc2', filename);

h = figure; 
p=plot(x1,s,x2,y);
filename = 'teste';
set(p,'Color','blue','LineWidth',4)
print(h, '-depsc2', filename);

