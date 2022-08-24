
%Constraints_Bargainig(0.5,0.2,m, V0, x0,0.3,0.2) 
clear 
grids=300
mupper=100
m=linspace(0.01,mupper,grids)
V0=log(m)
x0=[10,2]
[q,d,c]=Bargaining(23,0.1,m,V0,x0, 1)
c=-c