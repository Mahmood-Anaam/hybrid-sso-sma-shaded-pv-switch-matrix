
function [Destination_fitness,bestPositions,bestPosition_change,Convergence_curve] =SSSMA(A,SearchAgents_no,Max_iteration,fobj)

%Initialize the positions of salps
[SalpPositions,SalpPositions_changes]=initialization(A,SearchAgents_no);
%record the fitness of all salps
SalpFitness=inf*ones(1,SearchAgents_no);
FoodPosition =[];
FoodPosition_change=[];
FoodFitness = inf;





%Initialize the positions of all slime mold
% [SlimePositions,SlimePositions_changes]=initialization(A,SearchAgents_no);
SlimePositions = SalpPositions;
SlimePositions_changes = SalpPositions_changes;
%record the fitness of all slime mold
AllFitness = inf*ones(1,SearchAgents_no);
%fitness weight of each slime mold
weight = ones(SearchAgents_no,1);
z=0.03; % parameter
Destination_sma_fitness=inf;
best_sma_Positions=[];
best_sma_Position_change = [];






Destination_fitness=inf;
bestPositions=[];
bestPosition_change = [];
Convergence_curve = zeros(1,Max_iteration);
%% ........................ Main loop ........................%%
it = 1;
while  it <= Max_iteration
    
    %calculate the fitness of all algorithms...
    for i=1:SearchAgents_no
        AllFitness(1,i)=fobj(SlimePositions{i});
        SalpFitness(1,i) = fobj(SalpPositions{i});
    end
    
    

    %sort the fitness...
    
    [sorted_salps_fitness,sorted_indexes]=sort(SalpFitness);
    Sorted_SalpPositions = cell(SearchAgents_no, 1);
    Sorted_SalpPositions_changes  = cell(SearchAgents_no, 1);
    
    
    [SmellOrder,SmellIndex] = sort(AllFitness);
    Sorted_SlimePositions = cell(SearchAgents_no, 1);
    Sorted_SlimePositions_changes  = cell(SearchAgents_no, 1);
    
    for newindex=1:SearchAgents_no
        
        Sorted_SalpPositions{newindex}=SalpPositions{sorted_indexes(newindex)};
        Sorted_SalpPositions_changes{newindex}=SalpPositions_changes{sorted_indexes(newindex)};
        
        
        Sorted_SlimePositions{newindex}=SlimePositions{SmellIndex(newindex)};
        Sorted_SlimePositions_changes{newindex}=SlimePositions_changes{SmellIndex(newindex)};
    end
    
    %calculate FoodPosition,FoodFitness,FoodPosition_change ...
    if sorted_salps_fitness(1) < FoodFitness
        FoodPosition=Sorted_SalpPositions{1};
        FoodPosition_change = Sorted_SalpPositions_changes{1};
        FoodFitness=sorted_salps_fitness(1);
    end
    
    %calculate WF,BF,S ...
    worstFitness = SmellOrder(SearchAgents_no);
    bestSmaFitness = SmellOrder(1);
    S=bestSmaFitness-worstFitness+eps;
    
    
    
    
    %update the best fitness value and best position,Position change...
    if bestSmaFitness < Destination_sma_fitness
        best_sma_Positions=Sorted_SlimePositions{1};
        best_sma_Position_change = Sorted_SlimePositions_changes{1};
        Destination_sma_fitness = bestSmaFitness;
    end
    

    if Destination_sma_fitness<FoodFitness
        Destination_fitness = Destination_sma_fitness;
        bestPositions = best_sma_Positions;
        bestPosition_change = best_sma_Position_change;
        Convergence_curve(it)=Destination_sma_fitness;
       
        
    else
       
        Destination_fitness = FoodFitness;
        bestPositions = FoodPosition;
        bestPosition_change = FoodPosition_change;
        Convergence_curve(it)=FoodFitness;
    end
    
    
    
     % Update the Position of search agents (SSA)...
    for i=1:SearchAgents_no
        if i== 1
            [random_arrangement, position_changes] = randomize_matrix_vertically(FoodPosition);
        else
            [random_arrangement, position_changes] = randomize_matrix_vertically(SalpPositions{i-1});
        end
        
        SalpPositions{i} = random_arrangement;
        SalpPositions_changes{i} = position_changes;
        
    end
    
    
    
    
    %calculate the fitness weight of each slime mold...
    for i=1:SearchAgents_no
        if i<=(SearchAgents_no/2)
            weight(SmellIndex(i),1) = 1+rand()*log10((bestSmaFitness-SmellOrder(i))/(S)+1);
        else
            weight(SmellIndex(i),1) = 1-rand()*log10((bestSmaFitness-SmellOrder(i))/(S)+1);
        end
    end
    
    
    % Update the Position of search agents(SMA)...
    vc = 1-it/Max_iteration;
    
    for i=1:SearchAgents_no
        if rand<z
            
            [random_arrangement, position_changes] = randomize_matrix_vertically(SlimePositions{i});
            SlimePositions{i} = random_arrangement;
            SlimePositions_changes{i} = position_changes;
            
        else
            p =tanh(abs(AllFitness(i)-Destination_sma_fitness));
            r = rand();
            
            if r<p
                
                indexB = randi([1,SearchAgents_no]);
                B = SlimePositions{indexB};
                indexC = randi([1,SearchAgents_no]);
                C = SlimePositions{indexC};
                
                BC =[ B(:,1:5),C(:,6:9)];
                BCposition_changes=[SlimePositions_changes{indexB}(1:5);SlimePositions_changes{indexC}(6:9)];
                
                
                
                [random_arrangement, position_changes] = changearrangement(best_sma_Positions,SlimePositions_changes{i},BC,BCposition_changes,weight(i));
                SlimePositions{i} = random_arrangement;
                SlimePositions_changes{i} = position_changes;
                
            else
                
                [random_arrangement, position_changes] = changearrangement(SlimePositions{i},SlimePositions_changes{i},[],[],vc);
                SlimePositions{i} = random_arrangement;
                SlimePositions_changes{i} = position_changes;
            end
            
            
        end
        
    end %end for i ...
    
    
    
    
    
    
    
    
    
    
    
    
    
    % ..............................................
    
    it=it+1;
    
end % end while loop...











end %end func...



