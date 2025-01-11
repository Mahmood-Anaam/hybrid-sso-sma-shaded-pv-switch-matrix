function [PowerMax,sortedIrows,diff] = getInfo(A)

Irows = sum(A, 2)/1000; 
for i=1:length(Irows)
    Vcol(i,1)= sum(Irows >= Irows(i));
end

indexM=(1:length(Irows))';
PowerM=Irows.*Vcol; 
indexedIrows = horzcat(indexM, Irows,Vcol,PowerM);
 


PowerMax= max(PowerM);
sortedIrows = sortrows(indexedIrows,2);

diff = max(Irows)-min(Irows);



end

