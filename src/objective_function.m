function [PX] = objective_function(A)

Irows = sum(A, 2)/1000;
 for i=1:length(Irows)
     Vcol(i,1)= sum(Irows >= Irows(i));
 end

 PX=-sum(Irows.*Vcol);

end
