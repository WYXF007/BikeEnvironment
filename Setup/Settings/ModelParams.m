%% Environment

parameters.g        = 9.82;               % [kgm/s^2] Gravity
parameters.Ts       = 0.02;               % [s] Sample time
parameters.constV   = 2;
parameters.slopeV   = 0.5;

%% Bike

bike.mass           = 25;                 % [kg]
bike.height         = 1;                  % [m]
bike.wheelbase      = 1.1;                % [m] (b parameter)
bike.rearlength     = 0.4*bike.wheelbase; % [m] (a parameter)
bike.lambda         = pi/2;               % [rad]
bike.diamW1         = 0.5;                % [m] Diameter of back wheel
bike.diamW2         = 0.5;                % [m] Diameter of front wheel
bike.c              = 0;                  % [?] Depends on lambda and the fork geometry is 0 of lamda = pi/2
bike.velocity_friction = 0.01;            % [?] Friction proportional to speed
bike.constant_friction = 0.05;            % [N] Constant friction when moving

%% Model values

% Model input limits
model_settings.limit_input_min  = -5000;  % Rad/s^2
model_settings.limit_input_max  =  5000;  % Rad/s^2
model_settings.limit_torque_min = -5;   % Nm
model_settings.limit_torque_max =  5;   % Nm

% Simulated step response of steering position
model_settings.input_step_numerator     =  0.975;           
model_settings.input_step_denumerator   = [0.005 0.116 1];

% Model state limits
model_settings.limit_roll_angle_min     = -pi/2;     % Rad
model_settings.limit_roll_angle_max     =  pi/2;     % Rad
model_settings.limit_steer_angle_min    = -pi/4;     % Rad
model_settings.limit_steer_angle_max    =  pi/4;     % Rad
model_settings.limit_roll_rate_min      = -1000;      % Rad/s
model_settings.limit_roll_rate_max      =  1000;      % Rad/s
model_settings.limit_steer_rate_min     = -100;      % Rad/s
model_settings.limit_steer_rate_max     =  100;      % Rad/s


%% Model disturbances

model_settings.roll_disturbance_start_time = 5;
model_settings.roll_disturbance_duration = 2;
model_settings.roll_disturbance_amplitude = 1.5;

%% Position Model
position_model.Xmin = -1;
position_model.Ymin = -1;
position_model.Xmax = 5;
position_model.Ymax = 1;

position_model.XYplot = [
    position_model.Xmin,...
    position_model.Ymin,...
    position_model.Xmax,...
    position_model.Ymax...
    ];

position_model.P0 = [
    0 % backwheelX
    0 % backwheelY
    0 % frontwheelX
    0 % frontwheelY
];
position_model.P0(3) = position_model.P0(1) + bike.wheelbase;
position_model.P0(4) = position_model.P0(2);

%% Controller Values

controller.trajectory_p_gain = 0;

controller.vmin = 0.1;
controller.vmax = 10;
controller.Npoints = 200;

% controller.Q = [
%     10 0 0 0 0       % Theta
%     0 0.01 0 0 0         % Theta_dot
%     0 0 10000000 0 0         % Delta
%     0 0 0 0.1 0         % Delta_dot
%     0 0 0 0 10          % v
% ];

controller.Q = [
    100 0 0 0 0       % Theta
    0 10 0 0 0         % Theta_dot
    0 0 1000 0 0         % Delta
    0 0 0 1000 0         % Delta_dot
    0 0 0 0 1000          % v
];

controller.R = eye(2);

controller.setpoint = [
    0
    0
    0
    0
    5.5
];

%% State Space Inital State


v0 = 0; % m / s

state_space.linearization_point = [
    0
    0
    0
    0
    v0
];

state_space.x0 = [
    0       % theta
    0       % theta_dot
    0       % delta
    0       % delta_dot
    v0       % v
];
clear v0


%% Noise values

Noise.IMU = blkdiag(0.1*eye(3),0.001*eye(3));
Noise.roll_model = 0.01*eye(4);
Noise.velocity_model = 0.001;
Noise.velocity_sensor = 0.01;
Noise.steering_encoder_noise = 0.01*eye(2);


%% Observer Values

observer.rollQ = Noise.roll_model;
observer.rollR = diag([Noise.IMU(2,2), 0.0001, Noise.IMU(4,4), 0.0001]);

observer.Q = eye(5);
observer.R = blkdiag(Noise.IMU(2,2), Noise.IMU(4,4), Noise.steering_encoder_noise, Noise.velocity_sensor); 

observer.velocityQ = Noise.velocity_model;
observer.velocityR = Noise.velocity_sensor;

% Complementary Filter settings
observer.alpha = 0.99;



