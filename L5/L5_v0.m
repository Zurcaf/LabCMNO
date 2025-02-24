load('fp_lin_matrices_fit3.mat'); %%Load Matrices A, B, C, D
Qr = diag([10,0,1,0,0]); %Weight Matrix for x
Rr = 1; %Weight for the input variable
K = lqr(A, B, Qr, Rr); %Calculate feedback gain

new_A = A-(B*K);
% Step 3: Compute the eigenvalues of matrix A
new_eigenvalues = eig(new_A); 
% Step 4: Display the eigenvalues
disp('Eigenvalues of matrix A:');
disp(new_eigenvalues);