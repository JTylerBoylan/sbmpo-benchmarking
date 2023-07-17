%% analysis.m

clc
clear
close all

%%

[paths, ~] = sbmpo_results("../../../csv/nodes.csv");

f = [paths.nodes(:).f];
g = [paths.nodes(:).g];
h = f - g;

figure
subplot(3,1,1)
plot(f)
ylabel("F")
subplot(3,1,2)
plot(g)
ylabel("G")
subplot(3,1,3)
plot(h)
ylabel("H")

delta_F_avg = mean(diff(f))