% Horizon Time vs Grid Resolution Plot Results
% Jonathan T. Boylan

close all

shape = [length(horizon_time) length(grid_resolution_xy)];
limits = [horizon_time(1) horizon_time(end) ...
    grid_resolution_xy(1) grid_resolution_xy(end)];

stats = sbmpo_stats("../csv/stats.csv");

size = length(stats);
time_us = zeros(1, size);
num_iters = zeros(1, size);
cost = zeros(1, size);
success_rate = zeros(1, size);

for p = 1:size
    
    stat = stats(p);
    time_us(p) = stat.time_us;
    num_iters(p) = stat.iterations;
    cost(p) = stat.cost;
    success_rate(p) = stat.success_rate;

end

X = repmat(horizon_time, [shape(2) 1]);
Y = repmat(grid_resolution_xy.', [1 shape(1)]);

time_us = reshape(time_us, shape).';
num_iters = reshape(num_iters, shape).';
cost = reshape(cost, shape).';
success_rate = reshape(success_rate, shape).';

 success_filter = success_rate < 1;
 cost_filter = cost > 100.0 | cost < 0;
% 
 cost(success_filter | cost_filter) = NaN;
 time_us(success_filter | cost_filter) = NaN;
 num_iters(success_filter | cost_filter) = NaN;

figure
hold on
grid on
contourf(X,Y,time_us*1E-6)
title("Computation Time (s)")
ylabel("Grid Resolution")
xlabel("Sampling Horizon Time")
colorbar
plot([0.1 0.7], sqrt(2)*0.5*[0.1 0.7], '--r', 'LineWidth',3)
plot([0.1 0.7], sqrt(2)*1.0*[0.1 0.7], '--g', 'LineWidth',3)
plot([0.1 0.7], 2*1.0*[0.1 0.7], '--k', 'LineWidth',3)
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
plot([0.1 0.7], sqrt(2)*0.5*[0.1 0.7], '--r', 'LineWidth',3)
plot([0.1 0.7], sqrt(2)*1.0*[0.1 0.7], '--g', 'LineWidth',3)
plot([0.1 0.7], 2*1.0*[0.1 0.7], '--k', 'LineWidth',3)
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
plot([0.1 0.7], sqrt(2)*0.5*[0.1 0.7], '--r', 'LineWidth',3)
plot([0.1 0.7], sqrt(2)*1.0*[0.1 0.7], '--g', 'LineWidth',3)
plot([0.1 0.7], 2*1.0*[0.1 0.7], '--k', 'LineWidth',3)
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
plot([0.1 0.7], sqrt(2)*0.5*[0.1 0.7], '--r', 'LineWidth',3)
plot([0.1 0.7], sqrt(2)*1.0*[0.1 0.7], '--g', 'LineWidth',3)
plot([0.1 0.7], 2*1.0*[0.1 0.7], '--k', 'LineWidth',3)
%plot([0.5 0.5], [0.1 0.5], '--k', 'LineWidth', 3)
axis(limits)
box(axes1,'on')
grid(axes1,'on')
hold(axes1,'off')
colorbar

time_per_iter = time_us ./ num_iters;
