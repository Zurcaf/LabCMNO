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

% Define test configurations with fixed Qr
Qr = diag([10 0 1 0 0]);  % Fixed Qr

Qe_configs = {
    % Qe(1) plots
    diag([1 1 1 1 1]),      % Test7
    diag([10 1 1 1 1]),     % Test8
    diag([100 1 1 1 1]),    % Test9
    diag([1000 1 1 1 1]),   % Test10
    
    % Qe(3) plots
    diag([1 1 10 1 1]),     % Test11
    diag([1 1 100 1 1]),    % Test12
    diag([1 1 1000 1 1]),   % Test13
    
    % Qe(rest) plots
    diag([1 100 1 1 1]),    % Test14
    diag([1 1 1 100 1]),    % Test15
    diag([1 1 1 1 100])     % Test16
};

labels = {
    'Qe = [1 1 1 1 1]', 'Qe = [10 1 1 1 1]', 'Qe = [100 1 1 1 1]', 'Qe = [1000 1 1 1 1]', 'Qe = [1 1 10 1 1]', 'Qe = [1 1 100 1 1]', 'Qe = [1 1 1000 1 1]', 'Qe = [1 100 1 1 1]', 'Qe = [1 1 1 100 1]', 'Qe = [1 1 1 1 100]'                       % Qe(rest)
};

% Common parameters
Rr = 0.01;
x0 = [0.01 0 0.01 0 0]';
T = 5;
G = eye(size(A));
Re = eye(5);

% Initialize figures
figure(1); set(gcf, 'Position', [100, 100, 800, 600]); hold on; grid on;
title('Effect of Q_e(1) on \beta'); xlabel('Time (s)'); ylabel('\beta (degrees)');

figure(2); set(gcf, 'Position', [150, 150, 800, 600]); hold on; grid on;
title('Effect of Q_e(1) on \alpha'); xlabel('Time (s)'); ylabel('\alpha (degrees)');

figure(3); set(gcf, 'Position', [200, 200, 800, 600]); hold on; grid on;
title('Effect of Q_e(3) on \beta'); xlabel('Time (s)'); ylabel('\beta (degrees)');

figure(4); set(gcf, 'Position', [250, 250, 800, 600]); hold on; grid on;
title('Effect of Q_e(3) on \alpha'); xlabel('Time (s)'); ylabel('\alpha (degrees)');

figure(5); set(gcf, 'Position', [300, 300, 800, 600]); hold on; grid on;
title('Effect of Q_e(rest) on \beta'); xlabel('Time (s)'); ylabel('\beta (degrees)');

figure(6); set(gcf, 'Position', [350, 350, 800, 600]); hold on; grid on;
title('Effect of Q_e(rest) on \alpha'); xlabel('Time (s)'); ylabel('\alpha (degrees)');

% Simulate and plot for each configuration
for i = 1:length(Qe_configs)
    % LQR controller design with fixed Qr
    K = lqr(A, B, Qr, Rr);
    
    % Observer design with varying Qe
    L = lqe(A, G, C, Qe_configs{i}, Re);
    
    % Closed-loop system
    A8 = A - B*K - L*C;
    B8 = L;
    C8 = -K;
    D8 = [0 0 0 0 0];
    
    % Simulate (assuming 'stateobsrv' is your Simulink model)
    sim('stateobsrv', T);
    
    % Convert to degrees and plot in appropriate figures
    if i <= 4  % Qe(1) plots (Test7-10)
        figure(1); plot(t, rad2deg(beta), 'DisplayName', labels{i}, 'LineWidth', 1.5);
        figure(2); plot(t, rad2deg(alpha), 'DisplayName', labels{i}, 'LineWidth', 1.5);
    elseif i <= 7  % Qe(3) plots (Test11-13)
        figure(3); plot(t, rad2deg(beta), 'DisplayName', labels{i}, 'LineWidth', 1.5);
        figure(4); plot(t, rad2deg(alpha), 'DisplayName', labels{i}, 'LineWidth', 1.5);
    else  % Qe(rest) plots (Test14-16)
        figure(5); plot(t, rad2deg(beta), 'DisplayName', labels{i}, 'LineWidth', 1.5);
        figure(6); plot(t, rad2deg(alpha), 'DisplayName', labels{i}, 'LineWidth', 1.5);
    end
end

% Add legends and adjust plots
for i = 1:6
    figure(i);
    legend('show');
end

% Save figures
figure(1); saveas(gcf, 'Qe(1)_beta.pdf', 'pdf');
figure(2); saveas(gcf, 'Qe(1)_alpha.pdf', 'pdf');
figure(3); saveas(gcf, 'Qe(3)_beta.pdf', 'pdf');
figure(4); saveas(gcf, 'Qe(3)_alpha.pdf', 'pdf');
figure(5); saveas(gcf, 'Qe(rest)_beta.pdf', 'pdf');
figure(6); saveas(gcf, 'Qe(rest)_alpha.pdf', 'pdf');