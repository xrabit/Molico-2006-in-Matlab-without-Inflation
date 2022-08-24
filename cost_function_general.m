function c=cost_function_general(q,B,q_bar)

c=B.*(1./(q_bar-q)-1./(q_bar))
end