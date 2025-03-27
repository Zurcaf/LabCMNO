load('../IP_MODEL.mat'); %%Load Matrices A, B, C, D
C = [1 0 0 0 0; 
     0 1 0 0 0; 
     0 0 1 0 0; 
     0 0 0 1 0; 
     0 0 0 0 1];
D = [0 0 0 0 0]';
Qr = diag([10,100,1,0,0]); % Weight Matrix for x
Rr = 0.5; % Weight for the input variable
    
K = lqr(A, B, Qr, Rr); % Calculate feedback gain

% Simulate controller
x0 = [0 0 -0.005 0 0]';
T = 5; % Time duration of the simulation
G = eye(size(A)); % Gain of the process noise
Qe = eye(size(A))*10; % Variance of process errors
Re = eye(5); % Variance of measurement errors
L = lqe(A, G, C, Qe, Re); % Calculate estimator gains

A8 = A - B*K - L*C;
B8 = L;
C8 = -K;
D8 = [0 0 0 0 0];