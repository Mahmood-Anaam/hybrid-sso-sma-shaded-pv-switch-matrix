function [random_arrangement, position_changes] = changearrangement(A,Aposition_changes,B,Bposition_changes,w)

sb = size(B,2);
SA = size(A);

random_arrangement = A;
position_changes = Aposition_changes;

Nchanges = round(SA(2)*w);

for i = 1:Nchanges
    col = randi([1,SA(2)]);
    
    if sb>0
        random_arrangement(:,col)= B(:,col);
        position_changes{col}= Bposition_changes{col};
        
    else
        perm = randperm(SA(1));
        random_arrangement(:, col) = A(perm, col);
        position_changes{col} = [transpose(1:SA(1)), perm'];
        
        
        
    end
    
    
    
end









end %end func...

