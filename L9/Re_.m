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

% Define test configurations for Re
Re_configs = {
    eye(5)*0.1,    % Test17
    eye(5)*0.01,   % Test18
    eye(5)*0.001   % Test19
};
labels = {'Re = 0.1', 'Re = 0.01', 'Re = 0.001'};

% Common parameters
Rr = 0.01;
x0 = [0.01 0 0.01 0 0]';
T = 5;
G = eye(size(A));

% Initialize figures
figure(1);
set(gcf, 'Position', [100, 100, 800, 600]);
hold on;
grid on;
title('Effect of R_e on \beta');
xlabel('Time (s)');
ylabel('\beta (degrees)');

figure(2);
set(gcf, 'Position', [150, 150, 800, 600]);
hold on;
grid on;
title('Effect of R_e on \alpha');
xlabel('Time (s)');
ylabel('\alpha (degrees)');

% Simulate and plot for each configuration
for i = 1:length(Re_configs)
    % LQR controller design with fixed Qr
    K = lqr(A, B, Qr, Rr);
    
    % Observer design with fixed Qe and varying Re
    L = lqe(A, G, C, Qe, Re_configs{i});
    
    % Closed-loop system
    A8 = A - B*K - L*C;
    B8 = L;
    C8 = -K;
    D8 = [0 0 0 0 0];
    
    % Simulate (assuming 'stateobsrv' is your Simulink model)
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
saveas(gcf, 'Re_beta.pdf', 'pdf');

figure(2);
saveas(gcf, 'Re_alpha.pdf', 'pdf');