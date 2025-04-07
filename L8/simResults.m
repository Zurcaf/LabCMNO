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
Qr = diag([10 0 1 0 0]);    % Qr = [10 0 1 0 0]
Qe = eye(size(A))*10;       % Qe = 10*eye(size(A))
Rr = 1;                     % Rr = 1
Re = eye(5);                % Re = eye(5) to match C

% Common parameters
x0 = [0.1 0 0 0 0]';   % Initial conditions [alpha alphadot beta betadot current]
T = 4;                     % 4 seconds
G = eye(size(A));

% LQR controller design
K = lqr(A, B, Qr, Rr);

% Observer design
L = lqe(A, G, C, Qe, Re);

% First simulation: Closed-loop system with observer
A8 = A - B*K - L*C;
B8 = L;
C8 = -K;
D8 = [0 0 0 0 0];
sim('stateobsrv', T);
% Store first simulation results
t1 = t;
alpha1 = alpha;
alphadot1 = alphadot;
beta1 = beta;
betadot1 = betadot;
current1 = current;

% Second simulation: Closed-loop system without observer
A8 = A - B*K;
B8 = L;  % Keeping same input matrix
C8 = -K;
D8 = [0 0 0 0 0];
sim('stateobsrv', T);
% Store second simulation results
t2 = t;
alpha2 = alpha;
alphadot2 = alphadot;
beta2 = beta;
betadot2 = betadot;
current2 = current;

% Initialize figures for all 5 states with both simulations
figure(1); set(gcf, 'Position', [100, 100, 800, 600]); 
hold on; grid on;
plot(t1, rad2deg(alpha1), 'b-', 'LineWidth', 1.5, 'DisplayName', 'With Observer');
plot(t2, rad2deg(alpha2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Without Observer');
title('State: \alpha'); xlabel('Time (s)'); ylabel('\alpha (degrees)');
legend('show');

figure(2); set(gcf, 'Position', [150, 150, 800, 600]); 
hold on; grid on;
plot(t1, rad2deg(alphadot1), 'b-', 'LineWidth', 1.5, 'DisplayName', 'With Observer');
plot(t2, rad2deg(alphadot2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Without Observer');
title('State: \alpha_{dot}'); xlabel('Time (s)'); ylabel('\alpha_{dot} (degrees/s)');
legend('show');

figure(3); set(gcf, 'Position', [200, 200, 800, 600]); 
hold on; grid on;
plot(t1, rad2deg(beta1), 'b-', 'LineWidth', 1.5, 'DisplayName', 'With Observer');
plot(t2, rad2deg(beta2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Without Observer');
title('State: \beta'); xlabel('Time (s)'); ylabel('\beta (degrees)');
legend('show');

figure(4); set(gcf, 'Position', [250, 250, 800, 600]); 
hold on; grid on;
plot(t1, rad2deg(betadot1), 'b-', 'LineWidth', 1.5, 'DisplayName', 'With Observer');
plot(t2, rad2deg(betadot2), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Without Observer');
title('State: \beta_{dot}'); xlabel('Time (s)'); ylabel('\beta_{dot} (degrees/s)');
legend('show');

figure(5); set(gcf, 'Position', [300, 300, 800, 600]); 
hold on; grid on;
plot(t1, current1, 'b-', 'LineWidth', 1.5, 'DisplayName', 'With Observer');
plot(t2, current2, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Without Observer');
title('State: Current'); xlabel('Time (s)'); ylabel('Current (A)');
legend('show');

% Save figures
figure(1); saveas(gcf, 'alpha_state_comparison.pdf', 'pdf');
figure(2); saveas(gcf, 'alphadot_state_comparison.pdf', 'pdf');
figure(3); saveas(gcf, 'beta_state_comparison.pdf', 'pdf');
figure(4); saveas(gcf, 'betadot_state_comparison.pdf', 'pdf');
figure(5); saveas(gcf, 'current_state_comparison.pdf', 'pdf');