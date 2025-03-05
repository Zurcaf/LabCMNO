clear all; 
close all;

load('../IP_MODEL.mat'); % Load Matrices A, B, C, D
C = [1 0 0 0 0; 
     0 1 0 0 0; 
     0 0 1 0 0; 
     0 0 0 1 0; 
     0 0 0 0 1];
D = [0 0 0 0 0]';

% Values to test for each weight
values = [0.1, 1, 10, 15, 20, 50, 100, 500, 1000];
x = input('Number of the weight to test: ');

% Define custom figure sizes (in pixels)
plotWidth = 800;  % Width of the plot
plotHeight = 600; % Height of the plot

% Initialize figures with custom sizes
figure(1)
set(gcf, 'Position', [100, 100, plotWidth, plotHeight]); % [left, bottom, width, height]
if x ~= 6
    title(['Effect of weight Qr(' num2str(x) ') on beta'])
else
    title('Effect of weight Rr on beta')
end
hold on;

figure(2)
set(gcf, 'Position', [150, 150, plotWidth, plotHeight]); % Slightly offset to avoid overlap
if x ~= 6
    title(['Effect of weight Qr(' num2str(x) ') on alpha'])
else
    title('Effect of weight Rr on alpha')
end
hold on;
for i = 1:numel(values)
    Qr = diag([10,0,1,0,0]); % Weight Matrix for x
    if x ~= 6
        Qr(x,x) = values(i); % Modified to properly index diagonal element
    end
    Rr = 1; % Weight for the input variable
    if x == 6
        Rr = values(i);
    end
    
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
    sim('stateobsrv', T);
    
    figure(1)
    if x ~= 6
        gg = plot( t,  beta, 'DisplayName', ['Qr(' num2str(x) ') = ' num2str(values(i))]);
        legend('off'); legend('show')
    else
        gg = plot( t,  beta, 'DisplayName', ['Rr = ' num2str(values(i))]);
        legend('off'); legend('show')
    end
    set(gg, 'LineWidth', 1.5)
    gg = xlabel('Time (s)');
    set(gg, 'Fontsize', 14);
    gg = ylabel('\beta (rad)');
    set(gg, 'Fontsize', 14);
    
    figure(2)
    if x ~= 6
        gg = plot( t,  alpha, 'DisplayName', ['Qr(' num2str(x) ') = ' num2str(values(i))]);
        legend('off'); legend('show')
    else
        gg = plot( t,  alpha, 'DisplayName', ['Rr = ' num2str(values(i))]);
        legend('off'); legend('show')
    end
    set(gg, 'LineWidth', 1.5)
    gg = xlabel('Time (s)');
    set(gg, 'Fontsize', 14);
    gg = ylabel('\alpha (rad)');
    set(gg, 'Fontsize', 14);
end

% Save the plots automatically after the loop
if x ~= 6
    % Save beta plot
    figure(1)
    saveas(gcf, ['Effect_of_Qr' num2str(x) '_on_beta.pdf'], 'pdf');
    
    % Save alpha plot
    figure(2)
    saveas(gcf, ['Effect_of_Qr' num2str(x) '_on_alpha.pdf'], 'pdf');
else
    % Save beta plot
    figure(1)
    saveas(gcf, 'Effect_of_Rr_on_beta.pdf', 'pdf');
    
    % Save alpha plot
    figure(2)
    saveas(gcf, 'Effect_of_Rr_on_alpha.pdf', 'pdf');
end