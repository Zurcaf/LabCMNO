% Step 1: Load the model
load('../IP_MODEL.mat');
% Step 2: Display the variables in the workspace
who;
% Step 3: Compute the eigenvalues of matrix A
eigenvalues = eig(A); 
% Step 4: Display the eigenvalues
disp('Eigenvalues of matrix A:');
disp(eigenvalues);


