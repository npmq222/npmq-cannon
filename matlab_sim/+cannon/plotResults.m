function plotResults(result, summary, params)
%PLOTRESULTS Plot displacement, velocity, acceleration and firing force.

time = result.time;
labels = params.model.coordinates;

figure('Name', 'Cannon dynamic response', 'Color', 'w');
tiledlayout(4, 1, 'Padding', 'compact', 'TileSpacing', 'compact');

nexttile;
plot(time, summary.force, 'LineWidth', 1.4);
grid on;
ylabel('F(t) [N]');
title(params.model.name);

nexttile;
plot(time, result.displacement, 'LineWidth', 1.2);
grid on;
ylabel('q [m]');
legend(labels, 'Location', 'best');

nexttile;
plot(time, result.velocity, 'LineWidth', 1.2);
grid on;
ylabel('dq/dt [m/s]');

nexttile;
plot(time, summary.acceleration, 'LineWidth', 1.2);
grid on;
ylabel('d^2q/dt^2 [m/s^2]');
xlabel('Time [s]');
end
