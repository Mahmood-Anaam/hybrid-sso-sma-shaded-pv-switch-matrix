% This function initialize the first population of search agents

function [SalpPositions,SalpPositions_changes]=initialization(A,SearchAgents_no)
SalpPositions=cell(SearchAgents_no, 1);
SalpPositions_changes=cell(SearchAgents_no, 1);
for i=1:SearchAgents_no
    [random_arrangement, position_changes] = randomize_matrix_vertically(A);
    SalpPositions{i} = random_arrangement;
    SalpPositions_changes{i} = position_changes;
end

end