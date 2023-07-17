clc
clear
close all

stats1 = load("stats1").stats;
stats2 = load("stats2").stats;

time1 = [stats1.time_us];
time2 = [stats2.time_us];

x = 1:length(time1);

figure
hold on
grid on
plot(x, time1);
plot(x, time2);
xlabel("run")
ylabel("time (us)")
legend(["Time1" "Time2"])

figure
plot(time1./time2)
