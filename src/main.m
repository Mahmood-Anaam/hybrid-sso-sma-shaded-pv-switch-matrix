close all;
clear all;
clc;

%% .....................................Init Case............................................. %%

A = [1000 1000 1000 1000 1000 200 200 600 600;
     1000 1000 1000 1000 1000 200 200 600 600;
     1000 1000 1000 1000 1000 200 200 400 400;
     1000 1000 1000 1000 1000 200 200 400 400;
     1000 1000 1000 1000 1000 1000 1000 1000 1000;
     1000 1000 1000 1000 1000 1000 1000 1000 1000;
     1000 1000 1000 1000 1000 1000 1000 1000 1000;
     1000 1000 1000 1000 1000 1000 1000 1000 1000;
     1000 1000 1000 1000 1000 1000 1000 1000 1000];
 

%% ............................. algorthims..................................................... %%


SearchAgents_no=50; % Number of search agents
Max_iteration=1000; % Maximum numbef of iterations
fobj=@objective_function; % objective function

%  [Destination_fitness,bestPositions,bestPositions_change,Convergence_curve]=SSA(A,SearchAgents_no,Max_iteration,fobj);
% [Destination_fitness,bestPositions,bestPositions_change,Convergence_curve]=SMA(A,SearchAgents_no,Max_iteration,fobj);
  [Destination_fitness,bestPositions,bestPositions_change,Convergence_curve]=SSSMA(A,SearchAgents_no,Max_iteration,fobj);

%% ..................................Display results................................................ %%
diary DisplayResultsDiaryFile.txt
[PowerMax_org,sortedIrows_org,Minimum_Diff_Currents_org] = getInfo(A)

disp('Original Arrangement')
disp(A)

[PowerMax_Optimal,sortedIrows_Optimal,Minimum_Diff_Currents_Optimal] = getInfo(bestPositions)

disp('Optimal Arrangement')
disp(bestPositions)

disp('Power Enhancement (%):')
PowerEnhancement = 100*(PowerMax_Optimal-PowerMax_org)/PowerMax_Optimal;
disp(PowerEnhancement)

% Calculate matrix B and C
B = reshape(1:numel(A), size(A));
C = zeros(size(B));

for col = 1:size(B, 2)
    C(bestPositions_change{col}(:, 2), col) = B(bestPositions_change{col}(:, 1), col);
end

disp('Matrix B:');
disp(B);
disp('Matrix C:');
disp(C);
diary off
%% .................................................................................. %%

figure;
hold on;
semilogy(Convergence_curve,'Color','b','LineWidth',2);
xlabel('Iteration');
ylabel('Best Fitness');
title('Best Fitness over Iterations');
axis tight
grid off
box on
%% .................................................................................. %%

figure;
subplot(1,2,1);
imagesc(A);
title('Original Arrangement');
colorbar;

subplot(1,2,2);
imagesc(bestPositions);
title('Optimal Arrangement');
colorbar;