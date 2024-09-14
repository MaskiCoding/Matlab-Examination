% Parameters
m1 = 600; m2 = 45; m3 = 45; J = 1020; L = 2.5; p = 0.52;
k1 = 500e3; k2 = 20e3; k3 = 20e3;

% Mass matrix
M = diag([m1, m2, m3, J]);

% Stiffness matrix
K = [k1+k2, -k2, -k3, (1-p)*L*k2;
    -k2, k2, 0, -p*L*k2;
    -k3, 0, k3, -p*L*k3;
    (1-p)*L*k2, -p*L*k2, -p*L*k3, (p*L)^2*k2 + (1-p)*L*k3];

% Eigenvalue problem
[eigenvectors, eigenvalues] = eig(K, M);
eigenfrequencies = sqrt(diag(eigenvalues)) / (2 * pi); % Convert to Hz

% Display the eigenfrequencies
disp('Eigenfrequencies (Hz):');
disp(eigenfrequencies);

% Critical speeds
lambda = 16; % Wavelength of road profile (m)
Vcrit = lambda * eigenfrequencies; % Critical speed in m/s
Vcrit_kmh = Vcrit * 3.6; % Convert to km/h

fprintf('Critical speeds (km/h):\n');
disp(Vcrit_kmh);

% Plot the critical speeds on the previous graph
hold on;
yLimits = ylim; % Get current y-axis limits
for i = 1:length(Vcrit_kmh)
    line([Vcrit_kmh(i) Vcrit_kmh(i)], yLimits, 'LineStyle', '--', 'DisplayName', ['V_{crit} = ' num2str(Vcrit_kmh(i)) ' km/h']);
end
legend show;

% Report the Eigenvectors
disp('Eigenvectors:');
disp(eigenvectors);