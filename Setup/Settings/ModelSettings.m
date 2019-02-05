
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ONLY KEEP TOGGLE VALUES IN THIS FILE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Model settings: Variables here are connected to switches in the model
model_settings.limit_model_states = true;
model_settings.simulate_friction = false;

% TRUE = KALMAN | FALSE = COMPLEMENTARY
model_settings.use_kalman_filter = false;


%% Model disturbances

model_settings.roll_rate_disturbance = false;



%% Controller Settings
model_settings.use_static_controller = false;

% Use pure state instead of estimate
model_settings.bypass_kalman = false;

% Simulink implementation of lookup table for K.
% Faster simulation than "MATLAB Function" block
% Unfortunately doesn't seem to be faster..........
model_settings.simulink_implementation = true;

%% Trajectory settings
model_settings.use_trajectory = false;


%% Input settings
model_settings.limit_input = true;
model_settings.use_steering_step_response = false;

%% State limits
model_settings.limit_roll_angle = true;
model_settings.limit_steer_angle = true;
model_settings.limit_roll_rate = true;
model_settings.limit_steer_rate = true;

%% Noise settings

%%%%% NOISE MASTER SWITCH %%%%%%%
model_settings.disable_all_noise = false;

model_settings.enable_process_noise =   false        && ~model_settings.disable_all_noise;
model_settings.enable_imu_noise =       true         && ~model_settings.disable_all_noise;
model_settings.enable_encoder_noise =   true         && ~model_settings.disable_all_noise;
model_settings.enable_velocity_noise =  true         && ~model_settings.disable_all_noise;

%% Setting Speed profile case in range 1 -> 5, Case 1 is constant speed 
model_settings.SpeedProfile = 8;