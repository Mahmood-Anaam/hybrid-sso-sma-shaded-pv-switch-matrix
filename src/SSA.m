%_________________________________________________________________________________
%  Salp Swarm Algorithm (SSA) source codes 

function [FoodFitness,FoodPosition,FoodPosition_change,Convergence_curve]=SSA(A,SearchAgents_no,Max_iteration,fobj)



%Initialize the positions of salps
[SalpPositions,SalpPositions_changes]=initialization(A,SearchAgents_no);
%calculate the fitness of initial salps
SalpFitness=zeros(1,SearchAgents_no);
for i=1:SearchAgents_no
    SalpFitness(1,i)=fobj(SalpPositions{i});
end



[sorted_salps_fitness,sorted_indexes]=sort(SalpFitness);
Sorted_SalpPositions = cell(SearchAgents_no, 1);
Sorted_SalpPositions_changes  = cell(SearchAgents_no, 1);
for newindex=1:SearchAgents_no
    Sorted_SalpPositions{newindex}=SalpPositions{sorted_indexes(newindex)};
    Sorted_SalpPositions_changes{newindex}=SalpPositions_changes{sorted_indexes(newindex)};
end

FoodPosition=Sorted_SalpPositions{1};
FoodPosition_change = Sorted_SalpPositions_changes{1};
FoodFitness=sorted_salps_fitness(1);
Convergence_curve = zeros(1,Max_iteration);

%Main loop
l=2; % start from the second iteration since the first iteration was
     % dedicated to calculating the fitness of salps

while l<Max_iteration+1
    
    for i=1:SearchAgents_no
        if i== 1
            [random_arrangement, position_changes] = randomize_matrix_vertically(FoodPosition); 
        else
           [random_arrangement, position_changes] = randomize_matrix_vertically(SalpPositions{i-1});  
        end
        
       SalpPositions{i} = random_arrangement;
       SalpPositions_changes{i} = position_changes; 
       
    end
    
    for i=1:SearchAgents_no
        
        SalpFitness(1,i)=fobj(SalpPositions{i});
        if SalpFitness(1,i)<FoodFitness
            FoodPosition=SalpPositions{i};
            FoodPosition_change = SalpPositions_changes{i};
            FoodFitness=SalpFitness(1,i);
        end
    end
    
    Convergence_curve(l)=FoodFitness;
    l = l + 1;
end



