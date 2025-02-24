% Step 1: Load the model
load('fp_lin_matrices_fit3.mat');
% Step 2: Display the variables in the workspace
who;
% Step 3: Compute the Observability matrix for  measuring x3
c1 = [0,0,1,0,0];

observer_for_x3 = obsv (A, c1);
O1 = rank(observer_for_x3);

observer_for_x1_x3 = obsv(A, C);
O2 = rank(observer_for_x1_x3);

% Step 4: Display results
disp('Observability matrix:');
disp(observer_for_x3);
disp('Rank:');
disp(O1);
disp('Observability matrix:');
disp(observer_for_x1_x3);
disp('Rank:');
disp(O2);

