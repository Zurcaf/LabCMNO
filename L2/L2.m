% Step 1: Load the model
load('../IP_MODEL.mat');
% Step 2: Display the variables in the workspace
who;
% Step 3: Compute the Control matrix
control = ctrb(A, B);
R = rank(control);
% Step 4: Display results
disp('Control matrix:');
disp(control);
disp('Rank:');
disp(R);


