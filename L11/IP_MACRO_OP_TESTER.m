% ------------------------------
% CMNO 2024/2025 - Alberto Vale
% ------------------------------

% Load state model
load('IP_MODEL.mat')

% Constraints
V_MAX = 5; % Maximum motor voltage
V_MIN = -5; % Minimum motor voltage
ALPHA_MAX = 90 * pi/180; % Maximum angle accepted for motor shaft
BETA_MAX = 15 * pi/180; % Maximum angle before falling
TIME_DELAY = 6; % seconds before start
T = 30; % Time duration of the simulation
Ts = 0.001; % Sampling time

% BEST VALUES
% Qr = diag([300,0,150,0,0]); %Weight Matrix for x
% Rr = 0.01; %Weight for the input variable
% Qe = eye(size(A))*10; %Variance of process errors
% Re = eye(2); %Variance of measurement errors

%% Test configurations - Uncomment one at a time for each test
% Qr tests
% Qr = diag([1,0,1,0,0]); test_name = 'Qr_1_0_1_0_0';
% Qr = diag([10,0,1,0,0]); test_name = 'Qr_10_0_1_0_0';
% Qr = diag([100,0,1,0,0]); test_name = 'Qr_100_0_1_0_0';
% Qr = diag([1000,0,1,0,0]); test_name = 'Qr_1000_0_1_0_0';
% Qr = diag([10,0,0.1,0,0]); test_name = 'Qr_10_0_0d1_0_0';
% Qr = diag([10,0,10,0,0]); test_name = 'Qr_10_0_10_0_0';
Qr = diag([10,0,100,0,0]); test_name = 'Qr_10_0_100_0_0';
% Qr = diag([10,0,1000,0,0]); test_name = 'Qr_10_0_1000_0_0';

% Qe tests
% Qe = eye(5); test_name = 'Qe_1_1_1_1_1';
% Qe = diag([10,1,1,1,1]); test_name = 'Qe_10_1_1_1_1';
% Qe = diag([100,1,1,1,1]); test_name = 'Qe_100_1_1_1_1';
% Qe = diag([1000,1,1,1,1]); test_name = 'Qe_1000_1_1_1_1';
% Qe = diag([1,1,10,1,1]); test_name = 'Qe_1_1_10_1_1';
% Qe = diag([1,1,100,1,1]); test_name = 'Qe_1_1_100_1_1';
% Qe = diag([1,1,1000,1,1]); test_name = 'Qe_1_1_1000_1_1';
% Qe = diag([1,100,1,1,1]); test_name = 'Qe_1_100_1_1_1';
% Qe = diag([1,1,1,100,1]); test_name = 'Qe_1_1_1_100_1';
% Qe = diag([1,1,1,1,100]); test_name = 'Qe_1_1_1_1_100';

% Re tests
% Re = eye(2)*0.1; test_name = 'Re_0d1';
Re = eye(2)*0.01; test_name = 'Re_0d01';
% Re = eye(2)*0.001; test_name = 'Re_0d001';

% Rr tests
% Rr = 0.1; test_name = 'Rr_0d1';
Rr = 0.01; test_name = 'Rr_0d01';
% Rr = 0.001; test_name = 'Rr_0d001';

%% Controller and Estimator design
K = lqr(A, B, Qr, Rr); % Calculate feedback gain
L = lqe(A, eye(size(A)), C, Qe, Re); % Calculate estimator gains

%% Run your simulation here
sim('');

%% Save workspace with descriptive name
timestamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS');
save_filename = sprintf('TestResults_%s_%s.mat', test_name, timestamp);
save(save_filename);
fprintf('Saved workspace as: %s\n', save_filename);