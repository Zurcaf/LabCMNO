function cost = optimize_lqr(A, B, x)
    % Ensure positive semi-definite Q by taking absolute values
    Q = diag(abs(x(1:end-1))); 
    
    % Ensure strictly positive R by using max with a small epsilon
    epsilon = 1e-3;
    R = max(abs(x(end)), epsilon); 
    
    % Compute LQR gain
    K = lqr(A, B, Q, R); 
    
    % Compute closed-loop eigenvalues
    new_A = A - B * K; 
    eigenvalues = eig(new_A);
    
    % Define cost function: sum of absolute real parts of eigenvalues 
    % (to ensure stability and fast decay)
    cost = sum(abs(real(eigenvalues))); 
end
