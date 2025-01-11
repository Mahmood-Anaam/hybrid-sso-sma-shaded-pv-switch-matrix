function [Destination_fitness,bestPositions,bestPosition_change,Convergence_curve]=SMA(A,SearchAgents_no,Max_iteration,fobj)

%Initialize the positions of slimes
[SlimePositions,SlimePositions_changes]=initialization(A,SearchAgents_no);
%record the fitness of all slime mold
AllFitness = inf*ones(1,SearchAgents_no);
%fitness weight of each slime mold
weight = ones(SearchAgents_no,1);
z=0.03; % parameter

Destination_fitness=inf;
bestPositions=[];
bestPosition_change = [];

Convergence_curve = zeros(1,Max_iteration);
%% ........................ Main loop ........................%%
it = 1;
while  it <= Max_iteration
    
    %calculate the fitness of all slime mold...
    for i=1:SearchAgents_no
        AllFitness(1,i)=fobj(SlimePositions{i});
    end
    
    %sort the fitness...
    [SmellOrder,SmellIndex] = sort(AllFitness);
    Sorted_SlimePositions = cell(SearchAgents_no, 1);
    Sorted_SlimePositions_changes  = cell(SearchAgents_no, 1);
    for newindex=1:SearchAgents_no
        Sorted_SlimePositions{newindex}=SlimePositions{SmellIndex(newindex)};
        Sorted_SlimePositions_changes{newindex}=SlimePositions_changes{SmellIndex(newindex)};
    end
    
    %calculate WF,BF,S ...
    worstFitness = SmellOrder(SearchAgents_no);
    bestFitness = SmellOrder(1);
    S=bestFitness-worstFitness+eps;
    
    
    %calculate the fitness weight of each slime mold...
    for i=1:SearchAgents_no
        if i<=(SearchAgents_no/2)
            weight(SmellIndex(i),1) = 1+rand()*log10((bestFitness-SmellOrder(i))/(S)+1);
        else
            weight(SmellIndex(i),1) = 1-rand()*log10((bestFitness-SmellOrder(i))/(S)+1);
        end
    end
    
    
    %update the best fitness value and best position,Position change...
    if bestFitness < Destination_fitness
        bestPositions=Sorted_SlimePositions{1};
        bestPosition_change = Sorted_SlimePositions_changes{1};
        Destination_fitness = bestFitness;
    end
    
    
    
    % Update the Position of search agents...
    vc = 1-it/Max_iteration;
  
    for i=1:SearchAgents_no
        if rand<z
            
            [random_arrangement, position_changes] = randomize_matrix_vertically(SlimePositions{i});
            SlimePositions{i} = random_arrangement;
            SlimePositions_changes{i} = position_changes;
            
        else
            p =tanh(abs(AllFitness(i)-Destination_fitness));
            r = rand();
            
            if r<p
             
                indexB = randi([1,SearchAgents_no]);
                B = SlimePositions{indexB};
                indexC = randi([1,SearchAgents_no]);
                C = SlimePositions{indexC};
            
                BC =[ B(:,1:5),C(:,6:9)];
                BCposition_changes=[SlimePositions_changes{indexB}(1:5);SlimePositions_changes{indexC}(6:9)];
                
                
                
                [random_arrangement, position_changes] = changearrangement(bestPositions,SlimePositions_changes{i},BC,BCposition_changes,weight(i));
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
    Convergence_curve(it)=Destination_fitness;
    it=it+1;
    
end % end while loop...











end %end func...

