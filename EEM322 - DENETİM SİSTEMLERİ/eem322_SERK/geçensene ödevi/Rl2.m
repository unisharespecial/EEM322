num=[0 0 0 1 1];
den=[1 4 11 14 10];
rlocus(num,den);
v=[-10 10 -10 10];
axis(v);axis('square')
grid;
title('Root-Locus Plot of G(s)=K(s+1)/[(s^2+2s+2)(s^2+2s+5)]')

