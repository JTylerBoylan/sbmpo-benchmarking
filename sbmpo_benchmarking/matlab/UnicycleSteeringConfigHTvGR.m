%% Simple Robot Benchmark - Horizon Time vs. Grid Resolution Plot
% Jonathan Boylan
% 2023-03-01

clear
close all

%% Parameters

params = struct;
params.max_iterations = 1000000;
params.max_generations = 1000;
% params.horizon_time = 0.5;
params.num_states = 3;
params.num_controls = 2;
% params.grid_resolution = [0.3536, 0.3536, 0.0982];
params.start_state = [-5; -5; 0];
params.goal_state = [5; 5; 0];
params.branchout_factor = 27;
params.branchouts = [
    [0.5; -4*pi/16], ...
    [0.5; -3*pi/16], ...
    [0.5; -2*pi/16], ...
    [0.5; -1*pi/16], ...
    [0.5; 0], ...
    [0.5; +1*pi/16], ...
    [0.5; +2*pi/16], ...
    [0.5; +3*pi/16], ...
    [0.5; +4*pi/16], ...
    [0.75; -4*pi/16], ...
    [0.75; -3*pi/16], ...
    [0.75; -2*pi/16], ...
    [0.75; -1*pi/16], ...
    [0.75; 0], ...
    [0.75; +1*pi/16], ...
    [0.75; +2*pi/16], ...
    [0.75; +3*pi/16], ...
    [0.75; +4*pi/16], ...
    [1.0; -4*pi/16], ...
    [1.0; -3*pi/16], ...
    [1.0; -2*pi/16], ...
    [1.0; -1*pi/16], ...
    [1.0; 0], ...
    [1.0; +1*pi/16], ...
    [1.0; +2*pi/16], ...
    [1.0; +3*pi/16], ...
    [1.0; +4*pi/16]
    ];

horizon_time = linspace(0.1, 1.5, 100);
grid_resolution_xy = linspace(0.1, 1.0, 100);

for gr = 1:length(grid_resolution_xy)
    for ht = 1:length(horizon_time)
        params.horizon_time = horizon_time(ht);
        grid_res_xy = grid_resolution_xy(gr);
        grid_res_q = pi/16 * params.horizon_time;
        params.grid_resolution = [grid_res_xy; grid_res_xy; grid_res_q];

        % Write to config csv
        if (gr + ht == 2)
            sbmpo_config("../csv/config.csv", params, 1, true);
        else
            sbmpo_config("../csv/config.csv", params, 1, false);
        end  
   end
end


%% Other Params

goal_threshold = 0.5;
initial_state = [-5, -5];
goal_state = [5, 5];

%% Obstacles

obs = struct;
obs.min_n = 1;
obs.max_n = 1;
obs.min_x = 0;
obs.max_x = 0;
obs.min_y = 0;
obs.max_y = 0;
obs.min_r = 2.5;
obs.max_r = 2.5;

random_obstacles("../csv/obstacles.csv", obs, 1);
