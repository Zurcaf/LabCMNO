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
Qr = diag([10 0 1 0 0]);    % Fixed Qr
Qe = eye(5)*10;            % Fixed Qe = 10*eye(5)
Re = eye(5)*0.01;          % Fixed Re from previous context

% Define test configurations for Rr
Rr_configs = {
    0.1,      % Test23
    0.01,     % Test24
    0.001,    % Test25
    0.0001    % Test26
};
labels = {'Rr = 0.1', 'Rr = 0.01', 'Rr = 0.001', 'Rr = 0.0001'};

% Common parameters
x0 = [0.01 0 0.01 0 0]';
T = 5;                    % Extended to 15 seconds
G = eye(size(A));

% Initialize figures
figure(1);
set(gcf, 'Position', [100, 100, 800, 600]);
hold on;
grid on;
title('Effect of R_r on \beta with Perturbations');
xlabel('Time (s)');
ylabel('\beta (degrees)');

figure(2);
set(gcf, 'Position', [150, 150, 800, 600]);
hold on;
grid on;
title('Effect of R_r on \alpha with Perturbations');
xlabel('Time (s)');
ylabel('\alpha (degrees)');

% Simulate and plot for each configuration
for i = 1:length(Rr_configs)
    % LQR controller design with varying Rr
    K = lqr(A, B, Qr, Rr_configs{i});
    
    % Observer design with fixed Qe and Re
    L = lqe(A, G, C, Qe, Re);
    
    % Closed-loop system
    A8 = A - B*K - L*C;
    B8 = L;
    C8 = -K;
    D8 = [0 0 0 0 0];
    
    % Simulate (assuming 'stateobsrv' is your Simulink model with perturbations)
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
saveas(gcf, 'Rr_beta_perturbations.pdf', 'pdf');

figure(2);
saveas(gcf, 'Rr_alpha_perturbations.pdf', 'pdf');