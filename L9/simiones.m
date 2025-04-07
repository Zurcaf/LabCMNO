clc;
clear;
close all;

fileNames = {
    % 'Data/test_27.mat',
    % 'Data/test_34.mat',
    % 'Data/test_29.mat',
    % 'Data/test_28.mat',
    % 'Data/test_30.mat'
    % 'Data/test_31.mat',
    'Data/test_best.mat'
    % 'Data/test_best_with_weight.mat'
};

% Corresponding labels for legend
labels = {
    % 'Q_r = [10 1 1 1 1]',
    % 'Q_r = [100 1 1 1 1]',
    % 'Q_r = [10000 1 1 1 1]',
    % 'Q_e = [1 1 1 1 1]',
    % 'Q_e = [1 100 1 1 1]',
    % 'Q_e = [1 1 1 100 1]',
    % 'Q_e = [1 1 1 1 100]'
    % 'Q_e = [1 1 1 1 100]'
    % 'R_e = 0.1',
    % 'R_e = 0.01',
    % 'R_e = 0.001',
    % 'R_r = 0.1',
    % 'R_r = 0.01',
    % 'R_r = 0.001',
    % 'R_r = 0.0001'
    % 'Integrator \alpha = 0 \beta = 0',
    % 'Integrator \alpha = 0.5 \beta = 0',
    % 'Integrator \alpha = 1 \beta = 0',
    % 'Integrator \alpha = 10 \beta = 0',
    % 'Integrator \alpha = 0 \beta = 10',
    % 'Integrator \alpha = 1 \beta = 10'
    'Best Configuration',
    % 'Best Configuration with added weight at the top'
};

% Initialize plot
figure;
hold on;
grid on;
set(gcf, 'Position', [100, 100, 640, 480]);

% Loop through all datasets
for i = 1:length(fileNames)
    load(fileNames{i});
    data = alpha(7000:60000);
    % Assuming each file has 'alpha' and 'beta' variables
    plot((7000:7000+length(data)-1)*0.001,rad2deg(data), 'DisplayName', labels{i}, 'LineWidth', 1.5);

end
xlabel('Time(s)');
ylabel('\alpha (degrees)');
title('Best configuration \alpha');
legend('show');


figure;
hold on;
grid on;
set(gcf, 'Position', [100, 100, 640, 480]);
% Loop through all datasets
for i = 1:length(fileNames)
    load(fileNames{i});
    data = beta(7000:60000);
    plot((7000:7000+length(data)-1)*0.001,rad2deg(data), 'DisplayName', labels{i}, 'LineWidth', 1.5);
    
end

xlabel('Time(s)');
ylabel('\beta (degrees)');
title('Best configuration \beta');
legend('show');
