% Define constants
c1 = 1000; % Example value for c1, you should replace it with the actual value
p = 0.5; % Example value for p, you should replace it with the actual value
L = 1; % Example value for L, you should replace it with the actual value
q = 0.5; % Example value for q, you should replace it with the actual value

% Damping coefficient range
c2_values = 1e3:1e3:10e3; % From 1 to 10 kNs/m

% Initialize result array
driver_position_amplitudes = zeros(size(c2_values));

for i = 1:length(c2_values)
    c2 = c2_values(i);
    c3 = c2; % c3 varies with c2

    % Damping matrix
    C = [c1 + c2, -c2, -c3, (1-p)*L*c2;
        -c2, c2, 0, -p*L*c2;
        -c3, 0, c3, -p*L*c3;
        (1-p)*L*c2, -p*L*c2, -p*L*c3, (p*L)^2*c2 + (1-p)*L*c3];
    
    % Solve for displacement amplitudes using matrix equation
    % This part requires solving for the displacement amplitude (z_hat)
    % For simplicity, let's assume f_hat is zero, and solve the system
    % numerically for the damping effect.
    % Note: You need to define the mass matrix M and stiffness matrix K
    % Example:
    M = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]; % Replace with actual mass matrix
    K = [2, -1, 0, 0; -1, 2, -1, 0; 0, -1, 2, -1; 0, 0, -1, 2]; % Replace with actual stiffness matrix
    omega = 2 * pi * 1; % Example value for angular frequency, replace with actual value
    f_hat = [1; 0; 0; 0]; % Example external force vector, replace with actual values
    
    % Solve the system (M*omega^2 + C*omega + K) * z_hat = f_hat
    A = -omega^2 * M + 1i * omega * C + K;
    z_hat = A \ f_hat;

    % Calculate the amplitude at the driver position
    Fz_hat = z_hat(1) - q * z_hat(4); % Driver position vertical motion
    driver_position_amplitudes(i) = abs(Fz_hat);
end

% Plot the results
figure;
plot(c2_values / 1e3, driver_position_amplitudes); % Convert to kNs/m
xlabel('Damping coefficient c2 (kNs/m)');
ylabel('Amplitude at driver position (m)');
title('Vibration Amplitude vs. Damping Coefficient c2');

% Find Optimal Damping Coefficient
optimal_c2_idx = find(driver_position_amplitudes <= 0.04, 1);
if ~isempty(optimal_c2_idx)
    optimal_c2 = c2_values(optimal_c2_idx);
    fprintf('The smallest damping coefficient c2 such that the amplitude at the driver position does not exceed 4 cm is %.2f kNs/m\n', optimal_c2 / 1e3);
else
    fprintf('No damping coefficient c2 found such that the amplitude at the driver position does not exceed 4 cm.\n');
end

fprintf('The smallest damping coefficient c2 such that the amplitude at the driver position does not exceed 4 cm is %.2f kNs/m\n', optimal_c2 / 1e3);