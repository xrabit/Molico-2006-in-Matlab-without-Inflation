function [q,d,c,Ceq] = Bargaining(mb,ms,m, V, x_0, mupper, theta,mu,tau) ;
%this function computes the solution to a bargaining problem assuming that
%the buyer has all the bargaining power. I

% INPUT:
% mb=money of the buyer
% ms=money of the seller
% V=Value Function (1xn vector where n are number of grids)
% x_0= initial guess (2x1 vector)
% theta= Bargaining Power (set=1)
%mupper= highest value of the grid

% OUTPUT
% q: production of DM good
% d: quantity of money paid by buyer
% c: objective function
% Ceq: value of money




objective=@(x) -1*((Utility(x(1))+interp1(m,V,(mb-x(2)+tau)/(1+mu),'spline',"extrap")-interp1(m,V,(mb+tau)/(1+mu),'spline',"extrap"))^(theta)...
    *(interp1(m,V,(ms+x(2)+tau)/(1+mu),'spline',"extrap")-interp1(m,V,(ms+tau)/(1+mu),'spline',"extrap")-cost_function(x(1)))^(1-theta));
% The value of the buyer consists of his utility of consuming and his
% continuation value of exiting with a given amount of money. Since the
% value function is defined on the grid we use interpolation to get the
% value of money as a continuing function

%ALTERNATIVE OBJECTIVE FUNCTION: 
% objective=@(x) -(Utility(x(1))-cost_function(x(1)));

%CONSTRAINTS:

A=[];
b=[];
Aeq=[];
beq=[];
lb=[0,0]; %agents cannot spend or produce negative amounts
ub=[1,min(mb,mupper-ms)]; 
%q=1 is the highest possible q (the cost function is set up so)
%d cannot be higher than what the buyer has, mb, and d cannot be such that
%the seller ends up with more than mupper money (outside of the grid)


    function [C, Ceq] = circlecon(x); % the nonlinear constraint have the defined as a funcion
 C=[-(interp1(m,V,(ms+x(2)+tau)/(1+mu),'spline',"extrap")-interp1(m,V,(ms+tau)/(1+mu),'spline',"extrap")-cost_function(x(1)))...
     -(Utility(x(1))+interp1(m,V,(mb-x(2)+tau)/(1+mu),'spline',"extrap")-interp1(m,V,(mb+tau)/(1+mu),'spline',"extrap"))]; %no nonlinear inequalities
  Ceq=[];
      % nonlinear equality: the seller is indifferent between accepting deal and rejecting. 
 end
Cons=@circlecon; %we call the save function under  Cons

% APPLYING NON-LINEAR SOLVER:
[qd,c]=fmincon(objective,x_0,A,b,Aeq,beq,lb,ub,Cons);
    

q=qd(1);
d=qd(2);
if q==x_0(1)
    q=0;
end

if d==x_0(2)
    d=0;
end


Ceq=interp1(m,V,ms+d,'spline',"extrap")-interp1(m,V,ms,'spline',"extrap");

end

