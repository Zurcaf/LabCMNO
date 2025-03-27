load('../IP_MODEL.mat'); %%Load Matrices A, B, C, D

Ci = [1 0 0 0 0];

A = [A zeros(5,1);
    Ci 0];  

B = [B; 0];  
  
C = [1 0 0 0 0 0; 
     0 1 0 0 0 0; 
     0 0 1 0 0 0; 
     0 0 0 1 0 0; 
     0 0 0 0 1 0;
     0 0 0 0 0 1];
 
D = [0 0 0 0 0 0]';


Qr = diag([10,100,1,0,0,0.1]); % Weight Matrix for x
Rr = 0.5; % Weight for the input variable
    
K = lqr(A, B, Qr, Rr); % Calculate feedback gain

% Simulate controller
x0 = [0 0 -0.005 0 0 0]';
T = 5; % Time duration of the simulation
G = eye(size(A)); % Gain of the process noise
Qe = eye(size(A))*10; % Variance of process errors
Re = eye(size(A)); % Variance of measurement errors
L = lqe(A, G, C, Qe, Re); % Calculate estimator gains

A8 = A - B*K - L*C;
B8 = L;
C8 = -K;
D8 = [0 0 0 0 0 0];