function [cost_inflation,cost_inflation_share] = cost_of_Inflation(V_stability,V_inf,q_inf,lamdba_inf, alpha, x,c0) 

n_grid=size(V_stability);
n_grid=n_grid(1,1);
cost_inflation=zeros(1,n_grid);
cost_inflation_share=zeros(1,n_grid);
for i=2:n_grid
   % Dif=@(c) (V_stability(i,1)-V_inf(i,1))+alpha*x*((Utility(q_inf(i,:)-c)-Utility(q_inf(:,i)))*lamdba_inf...
        %-(cost_function(q_inf(:,i)-c)-cost_function(q_inf(:,i)))'*lamdba_inf);
        Dif=@(c) (V_stability(i,1)-V_inf(i,1))+(Utility(q_inf(i,:)*lamdba_inf-c)-Utility(q_inf(i,:)*lamdba_inf))
   
cost_inflation(1,i)=fsolve(Dif,c0);
q_inf(i,:)*lamdba_inf
cost_inflation_share(1,i)=cost_inflation(1,i)/(q_inf(i,:)*lamdba_inf);
   
end