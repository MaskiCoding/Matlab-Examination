% Subtask1.m
% Code for Subtask 1

% Read data from file
data = load('bil0404.dat');
V = data(:, 1); % Vehicle speed (km/h)
z1 = data(:, 2); % Chassis displacement amplitude (m)
theta = data(:, 3); % Chassis rotation amplitude (rad)
Fz = data(:, 4); % Vertical motion at driver position (m)

% Plot Displacement Amplitudes as Functions of Speed
figure;
amplitudes = {abs(z1), abs(theta), abs(Fz)};
labels = {'|z1| (m)', '|\theta| (rad)', '|Fz| (m)'};
titles = {'Chassis Displacement vs. Speed', 'Chassis Rotation vs. Speed', 'Vertical Motion at Driver Position vs. Speed'};

for i = 1:3
    subplot(3,1,i);
    plot(V, amplitudes{i});
    xlabel('Speed (km/h)');
    ylabel(labels{i});
    title(titles{i});
end

% Determine Maximum Displacement Amplitude
[maxFz, idxMax] = max(abs(Fz));
VmaxFz = V(idxMax); % Speed at which maximum vertical motion occurs
hold on;
plot(VmaxFz, maxFz, 'ro'); % Mark the maximum point
hold off;