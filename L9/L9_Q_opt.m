% Optimizer code
% The goal of this optimizer was to get a better understanding of the
% effects of the weights as well as have an idea of the relationship they
% might had in between them as to go to the lab with a more systematic
% method and approach

clear all; % Clean environment
close all;
load('../IP_MODEL.mat'); % Load Matrices A, B, C, D

% Change matrices to take into account the integrator
% This was only added after the integrator implementation
A = [A, zeros(5,1); C(1,:), 0];
B = [B; 0];
C = [1 0 0 0 0;
     0 1 0 0 0;
     0 0 1 0 0;
     0 0 0 1 0;
     0 0 0 0 1];
C = [C, [0;0;0;0;0]; zeros(1,5), 0.00000000001];
D = [0 0 0 0 0]';
D = [D; 0];

% Set a minimum a maximum value as to prevent impossible weights
min = 1e-6; % These values were adjusted from what we tested in the lab
max = 1e+6; % Much higher or lower than this and the pendulum would simply not work

% Define general values to test
popQr1 = [0.1, 1, 10, 15, 20, 50, 100, 500, 1000];
popQr2 = [0.1, 1, 10, 15, 20, 50, 100, 500, 1000];
popQr3 = [0.1, 1, 10, 15, 20, 50, 100, 500, 1000];
popQr4 = [0.1, 1, 10, 15, 20, 50, 100, 500, 1000];
popQr5 = [0.1, 1, 10, 15, 20, 50, 100, 500, 1000];

% From theory we know R will better if lower so we set the values to 4 orders below
popR = [0.1, 0.5, 1, 10, 15, 20, 50, 100, 500, 1000] * 1e-4;

% Initialize an errors variable with high number
errors = 100;

% Main loop of the optimizer this is where a lot of time is spent
for i = 1:numel(popQr1)
    for j = 1:numel(popQr2)
        for k = 1:numel(popQr3)
            for l = 1:numel(popQr4)
                for m = 1:numel(popQr5) % Fixed from popQr4 to popQr5
                    for n = 1:numel(popR)
                        Qr = diag([popQr1(i), popQr2(j), popQr3(k), popQr4(l), 0, popQr5(m)]);
                        Rr = popR(n);
                        
                        K = lqr(A, B, Qr, Rr); % Calculate feedback gain
                        
                        % Simulate controller assuming beta is not perfectly in 0
                        x0 = [0 0 -0.005 0 0, 0]';
                        T = 10; % Time duration of the simulation is low for speed purposes
                        G = eye(size(A)); % Gain of the process noise
                        Qe = eye(size(A)) * 10; % Variance of process errors
                        Re = eye(6); % Variance of measurement errors
                        L = lqe(A, G, C, Qe, Re); % Calculate estimator gains
                        A8 = A - B*K - L*C;
                        B8 = L;
                        C8 = -K;
                        D8 = [0 0 0 0 0 0];
                        sim('stateobsrv', T);

                        % Get our merit figure for both alpha and beta
                        error_alpha =  alpha.^2;
                        error_alpha = trapz( t, error_alpha);

                        error_beta =  beta.^2;
                        error_beta = trapz( t, error_beta);

                        ISE = error_alpha + error_beta;

                        % For every new error smaller than the current minimum save, plot and continue
                        if errors > ISE
                            close all;
                            disp('new values!')
                            errors = ISE;
                            Qr_f = Qr;
                            R_f = Rr;
                            disp(errors)
                            disp(Qr_f)
                            disp(R_f)
                            
%                             figure()
%                             gg = plot( t,  beta);
%                             set(gg, 'LineWidth', 1.5)
%                             gg = xlabel('Time (s)');
%                             set(gg, 'Fontsize', 14);
%                             gg = ylabel('\beta (rad)');
%                             set(gg, 'Fontsize', 14);
% 
%                             figure()
%                             gg = plot( t,  alpha);
%                             set(gg, 'LineWidth', 1.5)
%                             gg = xlabel('Time (s)');
%                             set(gg, 'Fontsize', 14);
%                             gg = ylabel('\alpha (rad)');
%                             set(gg, 'Fontsize', 14);
%                             drawnow
                        end
                    end
                end
            end
        end
    end
end

% Show the final best merit figure and weight values
disp(errors)
disp(Qr_f)
disp(R_f)