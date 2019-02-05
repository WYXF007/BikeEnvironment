close all
folderName = "saved_simulation_results";
% sub = strcat(folderName, '\\VaryingSpeedComplementary');
sub = strcat(folderName, '\\simulation37');
conv = 180/pi;
deg = true;

linewidth = 1.5;


T_state = load(strcat(sub,'\sim_tracking.mat'));
T_state_time = T_state.sim_tracking.time';
T_state_data = T_state.sim_tracking.signals.values';

if deg == true % convert from rad to deg
    T_state_data(1:2,:) = conv.*T_state_data(1:2,:);
    unit = ' Deg';
end

fig.SetpointTrackingVelocity = figure('Name','Setpoint Tracking Velocity','NumberTitle','off');
plot(T_state_time, T_state_data(3:4,:),'linewidth',linewidth);
grid on
h1 = legend('$v_{ref}$ - velocity ref','$v$ - velocity','location','best'); % Change font size
set(h1,'Interpreter','latex')
h1.FontSize = 16;
title('Setpoint Tracking Velocity')
xlabel('Time [s]')
ylabel('meters / s')

fig.SetpointTrackingRoll = figure('Name','Setpoint Tracking Theta','NumberTitle','off');
plot(T_state_time, T_state_data(1:2,:),'linewidth',linewidth);
grid on
h1 = legend('$\theta_{ref}$ - roll','$\theta$ - roll','location','best'); % Change font size
set(h1,'Interpreter','latex')
h1.FontSize = 16;
title('Setpoint Tracking Roll')
xlabel('Time [s]')
ylabel(unit)


fig.SetPointTracking = figure('Name','Setpoint Tracking','NumberTitle','off');

subplot(2,1,1);
plot(T_state_time, T_state_data(1:2,:),'linewidth',linewidth);
axis([0 60 -10 10]);
grid on
h1 = legend('$\theta_{ref}$ - roll','$\theta$ - roll','location','best'); % Change font size
set(h1,'Interpreter','latex')
h1.FontSize = 16;
title('Setpoint Tracking Roll')
xlabel('Time [s]')
ylabel(unit)

subplot(2,1,2);
plot(T_state_time, T_state_data(3:4,:),'linewidth',linewidth);
grid on
h1 = legend('$v_{ref}$ - velocity ref','$v$ - velocity','location','best'); % Change font size
set(h1,'Interpreter','latex')
h1.FontSize = 16;
title('Setpoint Tracking Velocity')
xlabel('Time [s]')
ylabel('meters / s')
axis([0 60 0 2.5]);



% Load controller output
Coord = load(strcat(sub,'\sim_XY_worldcoordinates.mat'));
%Coord_time = Coord.sim_XY_worldcoordinates.Time';
Coord_data = Coord.sim_XY_worldcoordinates.signals.values';

fig.Pos_Global = figure('Name','Position Worldframe','NumberTitle','off');

plot(Coord_data(1,:),Coord_data(2,:),'b'); hold on
plot(sim_est_position.signals.values(:,1),sim_est_position.signals.values(:,2),'r');
grid on
title('Position XY','Interpreter','latex')
legend('True','Estimated','location','best');



% 
% 
% Back = sim_bike_pos.signals.values(:,1:2);
% Front = sim_bike_pos.signals.values(:,3:4);
% 
% 
% fig.Pos_Global_Wheels = figure('Name','Position Wheels Worldframe','NumberTitle','off');
% 
% plot(Front(:,1),Front(:,2),'b'); hold on
% plot(Back(:,1),Back(:,2),'r');
% 
% grid on
% title('Position XY','Interpreter','latex')
% legend('Front','Back','location','best');
% 
% 
% 




