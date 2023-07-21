% Horizon Time vs Grid Resolution Plot Results
% Jonathan T. Boylan

close all

%stats = sbmpo_stats("../csv/stats.csv");

% -------------
% SAVED RESULT
stats = sbmpo_stats("../csv/saved/stats_GR00105_HT0010375_75x75_25obs.csv");
horizon_time = linspace(0.01, 0.5, 75);
grid_resolution_xy = linspace(0.01, 0.375, 75);
grid_resolution_q = 0.1963 * horizon_time;
% -------------

shape = [length(horizon_time) length(grid_resolution_xy)];
x_limits = [horizon_time(1) horizon_time(end)];
y_limits = [grid_resolution_xy(1) grid_resolution_xy(end)];
limits = [x_limits y_limits];

size = length(stats);
time_us = zeros(1, size);
num_iters = zeros(1, size);
cost = zeros(1, size);
success_rate = zeros(1, size);
exit_code = zeros(1, size);

for p = 1:size
    
    stat = stats(p);
    time_us(p) = stat.time_us;
    num_iters(p) = stat.iterations;
    cost(p) = stat.cost;
    success_rate(p) = stat.success_rate;
    exit_code(p) = stat.exit_code;

end

X = repmat(horizon_time, [shape(2) 1]);
Y = repmat(grid_resolution_xy.', [1 shape(1)]);

time_us = reshape(time_us, shape).';
num_iters = reshape(num_iters, shape).';
cost = reshape(cost, shape).';
success_rate = reshape(success_rate, shape).';
exit_code = reshape(exit_code, shape).';

 success_filter = success_rate == 0;
 cost_filter = cost > 100.0 | cost < 0;
 guideline1_filter = Y > 2/sqrt(2).*X;
% 
 cost(success_filter | cost_filter | guideline1_filter) = NaN;
 time_us(success_filter | cost_filter | guideline1_filter) = NaN;
 num_iters(success_filter | cost_filter | guideline1_filter) = NaN;

figure
hold on
grid on
contourf(X,Y,time_us*1E-6)
title("Computation Time (s)")
ylabel("Grid Resolution")
xlabel("Sampling Horizon Time")
colorbar
plot(x_limits, sqrt(2)*0.5*x_limits, '--r', 'LineWidth',3)
plot(x_limits, sqrt(2)*1.0*x_limits, '--g', 'LineWidth',3)
plot(x_limits, 2*1.0*x_limits, '--k', 'LineWidth',3)
%plot([0.5 0.5], [0.1 0.5], '--k', 'LineWidth', 3)
axis(limits)
%saveas(gcf, 'figures/time_050_01768.fig')

figure
hold on
grid on
contourf(X,Y,cost)
title("Cost")
ylabel("Grid Resolution")
xlabel("Sampling Horizon Time")
colorbar
plot(x_limits, sqrt(2)*0.5*x_limits, '--r', 'LineWidth',3)
plot(x_limits, sqrt(2)*1.0*x_limits, '--g', 'LineWidth',3)
plot(x_limits, 2*1.0*x_limits, '--k', 'LineWidth',3)
%plot([0.5 0.5], [0.1 0.5], '--k', 'LineWidth', 3)
axis(limits)
%saveas(gcf, 'figures/cost_050_01768.fig')

figure
hold on
grid on
contourf(X,Y, num_iters)
title("Iterations")
ylabel("Grid Resolution")
xlabel("Sampling Horizon Time")
colorbar
plot(x_limits, sqrt(2)*0.5*x_limits, '--r', 'LineWidth',3)
plot(x_limits, sqrt(2)*1.0*x_limits, '--g', 'LineWidth',3)
plot(x_limits, 2*1.0*x_limits, '--k', 'LineWidth',3)
%plot([0.5 0.5], [0.1 0.5], '--k', 'LineWidth', 3)
axis(limits)
%saveas(gcf, 'figures/iter_050_01768.fig')

figure1 = figure('Color',[1 1 1]);
axes1 = axes('Parent', figure1);
hold(axes1,'on');
contourf(X,Y,success_rate .* 100)
title("Success Rate (%)")
ylabel("Grid Resolution")
xlabel("Sampling Horizon Time")
plot(x_limits, sqrt(2)*0.5*x_limits, '--r', 'LineWidth',3)
plot(x_limits, sqrt(2)*1.0*x_limits, '--g', 'LineWidth',3)
plot(x_limits, 2*1.0*x_limits, '--k', 'LineWidth',3)
%plot([0.5 0.5], [0.1 0.5], '--k', 'LineWidth', 3)
axis(limits)
box(axes1,'on')
grid(axes1,'on')
hold(axes1,'off')
colorbar

figure
hold on
grid on
contourf(X,Y, exit_code)
title("Exit Code")
ylabel("Grid Resolution")
xlabel("Sampling Horizon Time")
colorbar
plot(x_limits, sqrt(2)*0.5*x_limits, '--r', 'LineWidth',3)
plot(x_limits, sqrt(2)*1.0*x_limits, '--g', 'LineWidth',3)
plot(x_limits, 2*1.0*x_limits, '--k', 'LineWidth',3)
%plot([0.5 0.5], [0.1 0.5], '--k', 'LineWidth', 3)
axis(limits)
%saveas(gcf, 'figures/iter_050_01768.fig')
colorbar


time_per_iter = time_us ./ num_iters;
