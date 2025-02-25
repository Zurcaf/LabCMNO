% Furuta pendulum - State feedback test
load('../IP_MODEL.mat'); %%Load Matrices A, B, C, D
Qr = diag([10,0,1,0,0]); %Weight Matrix for x
Rr = 1; %Weight for the input variable
K = lqr(A, B, Qr, Rr); %Calculate feedback gain
%----------------------------------------------------------------------
% Simulate controller
x0=[0.1 0 0 0 0]';
D=[0 0]';
% T=2; % Time duration of the simulation
% sim('L6_simu2022b',T);
% 
% gg=plot(t,x);
% set(gg,'LineWidth',1.5)
% gg=xlabel('Time (s9');
% set(gg,'’Fontsize',14);
% gg=ylabel('\beta (rad)');
% set(gg,'Fontsize',14);
%----------------------------------------------------------------------
% End of file