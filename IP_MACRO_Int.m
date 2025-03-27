% ------------------------------
% CMNO 2024/2025 - Alberto Vale
% ------------------------------

% Load state model
load('IP_MODEL.mat')

Ci = [1 0 0 0 0];

A = [A zeros(5,1);
    Ci 0];  

B = [B; 0];  
  
C = [1 0 0 0 0 0; 
     0 0 1 0 0 0; 
     0 0 0 0 0 1];
 
D = [0 0 0]';

% Constraints
V_MAX = 5; % Maximum motor voltage
V_MIN = -5; % Minimum motor voltage

ALPHA_MAX = 90 * pi/180; % Maximum angle accepted for motor shaft
BETA_MAX = 15 * pi/180; % Maximum angle before falling
TIME_DELAY = 6; % seconds before start

T = 30; % Time duration of the simulation
Ts = 0.001; % Sampling time

% Regulator parameters
Qr = diag([100,10,1,10,0,0.001]); %Weight Matrix for x
Rr = 0.25; %Weight for the input variable
K = lqr(A, B, Qr, Rr); %Calculate feedback gain

% Estimator parameters
G = eye(size(A)); %
Qe = eye(size(A))*10; %Variance of process errors
Re = eye(3); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re); %Calculate estimator gains

