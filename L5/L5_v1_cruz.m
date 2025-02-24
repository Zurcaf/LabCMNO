% Load system matrices
load('fp_lin_matrices_fit3.mat'); % Loads A, B, C, D

% Define initial weights for Q and R
Q_initial = diag([10, 0, 1, 0, 0]); 
R_initial = 1;

% Flatten Q and append R for optimization
x0 = [diag(Q_initial); R_initial];

% Run optimization using fminsearch
optimal_x = fminsearch(@(x) optimize_lqr(A, B, x), x0);

% Extract optimized Q and R
optimal_Q = diag(abs(optimal_x(1:end-1))); % Ensure Q is positive semi-definite
optimal_R = max(abs(optimal_x(end)), 1e-3); % Ensure R is positive definite

% Compute optimal LQR gain
K_optimal = lqr(A, B, optimal_Q, optimal_R);

% Display results
disp('Optimal Q matrix:');
disp(optimal_Q);
disp('Optimal R value:');
disp(optimal_R);
disp('Optimal LQR Gain K:');
disp(K_optimal);

% Compute closed-loop eigenvalues
new_A = A - B * K_optimal;
new_eigenvalues = eig(new_A);
disp('Optimal closed-loop eigenvalues:');
disp(new_eigenvalues);

