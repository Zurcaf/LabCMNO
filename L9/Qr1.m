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

% Define test configurations
Qr_configs = {
    diag([10 0 1 0 0]),    % Test1
    diag([100 0 1 0 0]),   % Test2
    diag([1000 0 1 0 0])   % Test3
};
labels = {'Qr = [10 0 1 0 0]', 'Qr = [100 0 1 0 0]', 'Qr = [1000 0 1 0 0]'};

% Common parameters
Rr = 0.01;
x0 = [0 0 -0.005 0 0]';
T = 5;
G = eye(size(A));
Qe = eye(size(A))*10;
Re = eye(5);

% Initialize figures
figure(1);
set(gcf, 'Position', [100, 100, 800, 600]);
hold on;
grid on;
title('Effect of Q_r on \beta');
xlabel('Time (s)');
ylabel('\beta (degrees)');

figure(2);
set(gcf, 'Position', [150, 150, 800, 600]);
hold on;
grid on;
title('Effect of Q_r on \alpha');
xlabel('Time (s)');
ylabel('\alpha (degrees)');

% Simulate and plot for each configuration
for i = 1:length(Qr_configs)
    % LQR controller design
    K = lqr(A, B, Qr_configs{i}, Rr);
    
    % Observer design
    L = lqe(A, G, C, Qe, Re);
    
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
saveas(gcf, 'Qr(1)_beta.pdf', 'pdf');

figure(2);
saveas(gcf, 'Qr(1)_alpha.pdf', 'pdf');

