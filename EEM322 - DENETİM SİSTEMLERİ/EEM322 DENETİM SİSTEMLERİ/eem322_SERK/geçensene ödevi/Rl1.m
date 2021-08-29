num=[0  0 150];
den=[1 1 150];
t=0:0.1:10;
r=t;
y=lsim(num,den,r,t);
plot(t,r,'-',t,y,'o')
grid 
title('Ramp response for different values of K');
xlabel('t Sec')
ylabel('Output')
text(3.2,6.5,'Unit Ramp Input')
text(6.0,3.1,'Output')