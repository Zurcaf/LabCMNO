clear all;
close all;

% Load system matrices
load('../IP_MODEL.mat'); % Assumes A, B are defined here
C = [1 0 0 0 0;
     0 1 0 0 0;
     0 0 1 0 0;
     0 0 0 1 0;
     0 0 0 0 1];
D = [0 0 0 0 0]';

% Define fixed matrices
Qr = diag([100 0 10 0 0]);    % Fixed Qr
Qe = diag([100 1 10000 1 1]);            % Fixed Qe = 10*eye(5)
Re = eye(5)*0.001;          % Fixed Re
Rr = 0.01;                 % Fixed Rr

% Define test configurations for I_alpha and I_beta
test_configs = {
    struct('I_alpha', 0, 'I_beta', 0),    % Test27
    struct('I_alpha', 0.5, 'I_beta', 0),  % Test28
    struct('I_alpha', 1, 'I_beta', 0),    % Test29
    % struct('I_alpha', 10, 'I_beta', 0),   % Test30
    struct('I_alpha', 0, 'I_beta', 10)    % Test31
};
labels = {
    'I_\alpha = 0, I_\beta = 0',
    'I_\alpha = 0.5, I_\beta = 0',
    'I_\alpha = 1, I_\beta = 0',
    %'I_\alpha = 10, I_\beta = 0',
    'I_\alpha = 0, I_\beta = 10'
};

% Common parameters
x0 = [0.1 0 0.1 0 0]';
T = 10;                    % 15 seconds with perturbations
G = eye(size(A));

% Initialize figures
figure(1);
set(gcf, 'Position', [100, 100, 800, 600]);
hold on;
grid on;
title('Effect of I_\alpha and I_\beta on \beta');
xlabel('Time (s)');
ylabel('\beta (degrees)');

figure(2);
set(gcf, 'Position', [150, 150, 800, 600]);
hold on;
grid on;
title('Effect of I_\alpha and I_\beta on \alpha');
xlabel('Time (s)');
ylabel('\alpha (degrees)');

% Simulate and plot for each configuration
for i = 1:length(test_configs)
    % LQR controller design
    K = lqr(A, B, Qr, Rr);
    
    % Observer design
    L = lqe(A, G, C, Qe, Re);
    
    % Closed-loop system
    A8 = A - B*K - L*C;
    B8 = L;
    C8 = -K;
    D8 = [0 0 0 0 0];
    
    % Define step inputs for Simulink
    t_sim = [0 T];  % Time vector for simulation
    I_alpha = test_configs{i}.I_alpha;  % Step input for alpha
    I_beta = test_configs{i}.I_beta;    % Step input for beta
    
    % Pass inputs to Simulink model (assuming 'stateobsrv' accepts these as inputs)
    sim('stateobsrv', T);
    
    % Convert to degrees and plot
    figure(1);
    plot(t, rad2deg(beta), 'DisplayName', labels{i}, 'LineWidth', 1.5);
    
    figure(2);
    plot(t, rad2deg(alpha), 'DisplayName', labels{i}, 'LineWidth', 1.5);
end

% Add legends and adjust plots
figure(1);
legend('show');

figure(2);
legend('show');

% Save figures
figure(1);
saveas(gcf, 'I_alpha_beta_perturbations_beta.pdf', 'pdf');

figure(2);
saveas(gcf, 'I_alpha_beta_perturbations_alpha.pdf', 'pdf');