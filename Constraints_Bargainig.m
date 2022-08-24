function [ineq_1, ineq_2,c_1] = Constraints_Bargainig(mb,ms,m, V, x_0,q,d)
ineq_1=mb-d
ineq_2=q
Vs_1=interp1(m,V,mb+d)
Vs_0=interp1(m,V,mb)
c_1=Vs_1-Vs_0-cost_function(q)

end