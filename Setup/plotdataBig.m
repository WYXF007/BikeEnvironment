function fig = plotdataBig(sub,angles, angular_velocity, velocity,estimated_angles,...
    estimated_angular_velocity, estimated_velocity,...
    measured_angles, measured_angular_velocity,...
    measured_velocity, compare_true_vs_measured,...
    compare_true_vs_estimated, estimated_state_error,...
    true_state_error, control_output, XY_Coordinates ,setpoint_tracking, deg)
% plotdata Plots the data in the selected folder

%   sub                        - Data location
%   angles                      - True state
%   angular_velocity            - True state
%   velocity                    - True state
%   estimated_angles            - Estimated state
%   estimated_angular_velocity  - Estimated state
%   estimated_velocity          - Estimated state
%   measured_angles             - Measured state
%   measured_angular_velocity   - Measured state
%   measured_velocity           - Measured state
%   compare_true_vs_measured    - Compare states
%   compare_true_vs_estimated   - Compare states
%   estimated_state_error       - Estimated state error
%   true_state_error            - True state error
%   control_output              - Controller output
%   XY_Coordinates              - Global coordinates
%   unit                        - 'rad' or 'deg' 

% Conversion
conv = 180/pi;
unit = ' Rad';

% True value plot
if (angles|angular_velocity|velocity) == true
    T_state = load(strcat(sub,'\sim_true_state.mat'));
    T_state_time = T_state.sim_true_state.time';
    T_state_data = T_state.sim_true_state.signals.values';
    
    if deg == true % convert from rad to deg
        T_state_data(1:4,:) = conv.*T_state_data(1:4,:);
        unit = ' Deg';
    end
    
    % Plot of angles steering and roll
    if angles == true
       fig.T_ang = figure('Name',strcat('True angles, unit: ',unit),'NumberTitle','off');
       plot(T_state_time, T_state_data(3,:),'b')
       hold on
       plot(T_state_time, T_state_data(1,:),'r')
       grid on
       h1 = legend('$\delta$ - steering','$\theta$ - roll');  % Change font size
       set(h1,'Interpreter','latex');
       h1.FontSize = 16;
       title('True state, angles')
       xlabel('Time')
       ylabel(unit)
       hold off
    end
    
    % Plot angular velocity
    if angular_velocity == true 
       fig.T_ang_vel = figure('Name',strcat('True angular velocity, unit: ',unit,'/s'),'NumberTitle','off');
       plot(T_state_time, T_state_data(4,:),'b')
       hold on
       plot(T_state_time, T_state_data(2,:),'r')
       grid on
       h1 = legend('$$\dot{\delta}$$','$$\dot{\theta}$$'); % Change font size
       set(h1,'Interpreter','latex')
       h1.FontSize = 16;
       title('True state, angular velocity')
       xlabel('Time')
       ylabel(strcat(unit,' /s'))
       hold off
       
    end
    
    % Plot velocity
    if velocity == true 
       fig.T_vel = figure('Name','True velocity','NumberTitle','off');
       plot(T_state_time, T_state_data(5,:),'b')
       grid on
       h1 = legend('v - velocity'); % Change font size
       set(h1,'Interpreter','latex')
       title('True state, velocity')
       xlabel('Time')
       ylabel('meters / s')
    end  
end
    

% Setpoint tracking
if setpoint_tracking
    
    T_state = load(strcat(sub,'\sim_tracking.mat'));
    T_state_time = T_state.sim_tracking.time';
    T_state_data = T_state.sim_tracking.signals.values';
    
    if deg == true % convert from rad to deg
        T_state_data(1:2,:) = conv.*T_state_data(1:2,:);
        unit = ' Deg';
    end
    
    fig.SetpointTrackingVelocity = figure('Name','Setpoint Tracking Velocity','NumberTitle','off');
    plot(T_state_time, T_state_data(3:4,:));
    grid on
    h1 = legend('$v_{ref}$ - velocity ref','$v$ - velocity','location','best'); % Change font size
    set(h1,'Interpreter','latex')
    h1.FontSize = 16;
    title('Setpoint Tracking Velocity')
    xlabel('Time')
    ylabel('meters / s')
    
    fig.SetpointTrackingRoll = figure('Name','Setpoint Tracking Theta','NumberTitle','off');
    plot(T_state_time, T_state_data(1:2,:));
    grid on
    h1 = legend('$\theta_{ref}$ - roll','$\theta$ - roll','location','best'); % Change font size
    set(h1,'Interpreter','latex')
    h1.FontSize = 16;
    title('Setpoint Tracking Roll')
    xlabel('Time')
    ylabel(unit)

    
    fig.SetPointTracking = figure('Name','Setpoint Tracking','NumberTitle','off');
  
    subplot(2,1,1);
    plot(T_state_time, T_state_data(1:2,:));
    grid on
    h1 = legend('$\theta_{ref}$ - roll','$\theta$ - roll','location','best'); % Change font size
    set(h1,'Interpreter','latex')
    h1.FontSize = 16;
    title('Setpoint Tracking Roll')
    xlabel('Time')
    ylabel(unit)
    
    subplot(2,1,2);
    plot(T_state_time, T_state_data(3:4,:));
    grid on
    h1 = legend('$v_{ref}$ - velocity ref','$v$ - velocity','location','best'); % Change font size
    set(h1,'Interpreter','latex')
    h1.FontSize = 16;
    title('Setpoint Tracking Velocity')
    xlabel('Time')
    ylabel('meters / s')
    
    
end



% Measured value plot
if (measured_angles|measured_angular_velocity|measured_velocity) == true
    M_state = load(strcat(sub,'\sim_measured_state.mat'));
    M_state_time = M_state.sim_measured_state.time';
    M_state_data = M_state.sim_measured_state.signals.values';
    
    if deg == true % convert from rad to deg
        M_state_data(1:4,:) = conv.*M_state_data(1:4,:);
        unit = ' Deg';
    end
    
    % Plot of angles steering and roll
    if measured_angles == true
       fig.M_ang = figure('Name',strcat('Measured angles, unit: ',unit),'NumberTitle','off');
       plot(M_state_time, M_state_data(3,:),'b')
       hold on
       plot(M_state_time, M_state_data(1,:),'r')
       grid on
       h1 = legend('$\delta$ - steering','$\theta$ - roll','location','best');  % Change font size
       set(h1,'Interpreter','latex');
       title('Measured state, angles')
       xlabel('Time')
       ylabel(unit)
       hold off
    end
    
    % Plot angular velocity
    if angular_velocity == true 
       fig.M_ang_vel = figure('Name',strcat('Measured angular velocity, unit: ',unit,'/s'),'NumberTitle','off');
       plot(M_state_time, M_state_data(4,:),'b')
       hold on
       plot(M_state_time, M_state_data(2,:),'r')
       grid on
       h1 = legend('$$\dot{\delta}$$','$$\dot{\theta}$$','location','best'); % Change font size
       set(h1,'Interpreter','latex')
       title('Measured state, angular velocity')
       xlabel('Time')
       ylabel(strcat(unit,' /s'))
       hold off
    end
    
    % Plot velocity
    if velocity == true 
       fig.M_vel = figure('Name','True velocity','NumberTitle','off');
       plot(M_state_time, M_state_data(5,:),'b')
       grid on
       h1 = legend('v - velocity','location','best'); % Change font size
       set(h1,'Interpreter','latex')
       title('Measured state, velocity')
       xlabel('Time')
    end   
end





% Estimated value plot
if (estimated_angles|estimated_angular_velocity|estimated_velocity) == true
 E_state = load(strcat(sub,'\sim_estimated_state.mat'));
    E_state_time = E_state.sim_estimated_state.time';
    E_state_data = E_state.sim_estimated_state.signals.values';
    
    if deg == true % convert from rad to deg
        E_state_data(1:4,:) = conv.*E_state_data(1:4,:);
        unit = ' Deg';
    end
    
    % Plot of angles steering and roll
    if angles == true
       fig.E_ang = figure('Name',strcat('Estimated angles, unit: ',unit),'NumberTitle','off');
       plot(E_state_time, E_state_data(3,:),'b')
       hold on
       plot(E_state_time, E_state_data(1,:),'r')
       grid on
       h1 = legend('$\delta$ - steering','$\theta$ - roll','location','best');  % Change font size
       set(h1,'Interpreter','latex');
       title('True state, angles')
       xlabel('Time')
       ylabel(unit)
       hold off
    end
    
    % Plot angular velocity
    if angular_velocity == true 
       fig.E_ang_vel = figure('Name',strcat('Estimated angular velocity, unit: ',unit,'/s'),'NumberTitle','off');
       plot(E_state_time, E_state_data(4,:),'b')
       hold on
       plot(E_state_time, E_state_data(2,:),'r')
       grid on
       h1 = legend('$$\dot{\delta}$$','$$\dot{\theta}$$','location','best'); % Change font size
       set(h1,'Interpreter','latex')
       title('Estimated state, angular velocity')
       xlabel('Time')
       ylabel(strcat(unit,' /s'))
       hold off
       
    end
    
    % Plot velocity
    if velocity == true 
       fig.E_vel = figure('Name','Estimated velocity','NumberTitle','off');
       plot(E_state_time, E_state_data(5,:),'b')
       grid on
       h1 = legend('v - velocity','location','best'); % Change font size
       set(h1,'Interpreter','latex')
       title('Estimated state, velocity')
       xlabel('Time')
    end
end
    

if compare_true_vs_measured == true
    % Load true state data 
    T_state = load(strcat(sub,'\sim_true_state.mat'));
    T_state_time = T_state.sim_true_state.time';
    T_state_data = T_state.sim_true_state.signals.values';    
    
    % Load measurement state data
    M_state = load(strcat(sub,'\sim_measured_state.mat'));
    M_state_time = M_state.sim_measured_state.time';
    M_state_data = M_state.sim_measured_state.signals.values';
    
    if deg == true
       M_state_data(1:4,:) = conv.*M_state_data(1:4,:);
       T_state_data(1:4,:) = conv.*T_state_data(1:4,:);
       unit = ' Deg';
    end
    
    fig.M_vs_T = figure('Name','Measured state vs True state','NumberTitle','off');
    
    subplot(3,2,1) % delta 3
    plot(M_state_time,M_state_data(3,:),'b')
    hold on
    plot(T_state_time,T_state_data(3,:),'r')
    h1 = legend('$$\delta_{M}$$','$$\delta_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title('Steering angle - $$\delta$$','Interpreter','latex')
        
    subplot(3,2,2) % theta 1
    plot(M_state_time,M_state_data(1,:),'b')
    hold on
    plot(T_state_time,T_state_data(1,:),'r')
    h1 = legend('$$\theta_{M}$$','$$\theta_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title('Roll angle - $$\theta$$','Interpreter','latex')
    
    
    subplot(3,2,3) % ddelta 2
    plot(M_state_time,M_state_data(2,:),'b')
    hold on
    plot(T_state_time,T_state_data(2,:),'r')
    h1 = legend('$$\dot{\delta}_{M}$$','$$\dot{\delta}_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title(strcat(strcat('Steering angular rate - $$\dot{\delta}$$ -',unit),' /s'),'Interpreter','latex')
    
    
    subplot(3,2,4) % dtheta 3
    plot(M_state_time,M_state_data(3,:),'b')
    hold on
    plot(T_state_time,T_state_data(3,:),'r')
    h1 = legend('$$\dot{\theta}_{M}$$','$$\dot{\theta}_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title(strcat(strcat('Roll angular rate - $$\dot{\theta}$$ -',unit),' /s'),'Interpreter','latex')
    
    
    subplot(3,2,[5,6]) % vel 5
    plot(M_state_time,M_state_data(5,:),'b')
    hold on
    plot(T_state_time,T_state_data(5,:),'r')
    h1 = legend('$$v_{M}$$','$$v_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title('Velocity - v','Interpreter','latex')
    
end


if compare_true_vs_estimated == true
    % Load true state data
    T_state = load(strcat(sub,'\sim_true_state.mat'));
    T_state_time = T_state.sim_true_state.time';
    T_state_data = T_state.sim_true_state.signals.values';    
    
    % Load Estimated data
    E_state = load(strcat(sub,'\sim_estimated_state.mat'));
    E_state_time = E_state.sim_estimated_state.time';
    E_state_data = E_state.sim_estimated_state.signals.values';
    
    if deg == true
       E_state_data(1:4,:) = conv.*E_state_data(1:4,:);
       T_state_data(1:4,:) = conv.*T_state_data(1:4,:);
       unit = ' Deg';
    end
    
    fig.E_vs_T = figure('Name','Estimated state vs True state','NumberTitle','off');
    
    subplot(3,2,1) % delta 3
    plot(E_state_time,E_state_data(3,:),'b')
    hold on
    plot(T_state_time,T_state_data(3,:),'r')
    h1 = legend('$$\delta_{E}$$','$$\delta_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title('Steering angle - $$\delta$$','Interpreter','latex')
        
    subplot(3,2,2) % theta 1
    plot(E_state_time,E_state_data(1,:),'b')
    hold on
    plot(T_state_time,T_state_data(1,:),'r')
    h1 = legend('$$\theta_{E}$$','$$\theta_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title('Roll angle - $$\theta$$','Interpreter','latex')
    
    
    subplot(3,2,3) % ddelta 2
    plot(E_state_time,E_state_data(2,:),'b')
    hold on
    plot(T_state_time,T_state_data(2,:),'r')
    h1 = legend('$$\dot{\delta}_{E}$$','$$\dot{\delta}_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title(strcat(strcat('Steering angular rate - $$\dot{\delta}$$ -',unit),' /s'),'Interpreter','latex')
    
    
    subplot(3,2,4) % dtheta 3
    plot(E_state_time,E_state_data(3,:),'b')
    hold on
    plot(T_state_time,T_state_data(3,:),'r')
    h1 = legend('$$\dot{\theta}_{E}$$','$$\dot{\theta}_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title(strcat(strcat('Roll angular rate - $$\dot{\theta}$$ -',unit),' /s'),'Interpreter','latex')
    
    
    subplot(3,2,[5,6]) % vel 5
    plot(E_state_time,E_state_data(5,:),'b')
    hold on
    plot(T_state_time,T_state_data(5,:),'r')
    h1 = legend('$$v_{E}$$','$$v_{T}$$','location','best');
    set(h1,'Interpreter','latex')
    title('Velocity - v','Interpreter','latex')
    
end




if estimated_state_error == true % Change to struct with time
    % Load estimated state error
    ES_state = load(strcat(sub,'\sim_estimated_state_error.mat'));
    ES_state_time = ES_state.sim_estimated_state_error.time';
    ES_state_data = ES_state.sim_estimated_state_error.signals.values';
    
    if deg == true
       ES_state_data(1:4,:) = conv.*ES_state_data(1:4,:);
       unit = ' Deg';
    end
    
    fig.E_error = figure('Name','Estimated state error','NumberTitle','off');
    
    subplot(3,2,1) % delta 3
    plot(ES_state_time,ES_state_data(3,:),'b')
    hold on
    grid on
    title('Steering angle - $$\delta$$','Interpreter','latex')
        
    subplot(3,2,2) % theta 1
    plot(ES_state_time,ES_state_data(1,:),'b')
    grid on
    title('Roll angle - $$\theta$$','Interpreter','latex')
    
    
    subplot(3,2,3) % ddelta 2
    plot(ES_state_time,ES_state_data(2,:),'b')
    grid on
    title(strcat(strcat('Steering angular rate - $$\dot{\delta}$$ -',unit),' /s'),'Interpreter','latex')
    
    
    subplot(3,2,4) % dtheta 3
    plot(ES_state_time,ES_state_data(3,:),'b')
    grid on
    title(strcat(strcat('Roll angular rate - $$\dot{\theta}$$ -',unit),' /s'),'Interpreter','latex')
    
    
    subplot(3,2,[5,6]) % vel 5
    plot(ES_state_time,ES_state_data(5,:),'b')
    grid on
    title('Velocity - v','Interpreter','latex')
        
end


if true_state_error == true
    % Load true state error
    TS_state = load(strcat(sub,'\sim_true_state_error.mat'));
    TS_state_time = TS_state.sim_true_state_error.time';
    TS_state_data = TS_state.sim_true_state_error.signals.values';
    
   
    if deg == true
       TS_state_data(1:4,:) = conv.*TS_state_data(1:4,:);
       unit = ' Deg';
    end
    
    fig.T_error = figure('Name','True state error','NumberTitle','off');
    
    subplot(3,2,1) % delta 3
    plot(TS_state_time,TS_state_data(3,:),'r')
    grid on
    title('Steering angle - $$\delta$$','Interpreter','latex')
        
    subplot(3,2,2) % theta 1
    plot(TS_state_time,TS_state_data(1,:),'r')
    grid on
    title('Roll angle - $$\theta$$','Interpreter','latex')
    
    
    subplot(3,2,3) % ddelta 2
    plot(TS_state_time,TS_state_data(2,:),'r')
    grid on
    title(strcat(strcat('Steering angular rate - $$\dot{\delta}$$ -',unit),' /s'),'Interpreter','latex')
    
    
    subplot(3,2,4) % dtheta 3
    plot(TS_state_time,TS_state_data(3,:),'r')
    grid on
    title(strcat(strcat('Roll angular rate - $$\dot{\theta}$$ -',unit),' /s'),'Interpreter','latex')
    
    
    subplot(3,2,[5,6]) % vel 5
    plot(TS_state_time,TS_state_data(5,:),'r')
    grid on
    title('Velocity - v','Interpreter','latex')
        
end

if control_output == true
    % Load controller output
    C_out = load(strcat(sub,'\sim_control_output.mat'));
    C_out_time = C_out.sim_control_output.time';
    C_out_data = C_out.sim_control_output.signals.values';
    
    TS_state = load(strcat(sub,'\sim_true_state_error.mat'));
    TS_state_time = TS_state.sim_true_state_error.time';
    TS_state_data = TS_state.sim_true_state_error.signals.values';
    
    fig.Control_out = figure('Name','Controller output','NumberTitle','off');
    
    subplot(3,2,1) % dddelta
    plot(C_out_time,C_out_data(1,:),'r')
    grid on
    title('Steering angular acceleration - $$\ddot{\delta}$$','Interpreter','latex')
        
    subplot(3,2,2) % Tourqe
    plot(TS_state_time,TS_state_data(1,:),'r')
    grid on
    title('Tourque - T','Interpreter','latex')
end


if XY_Coordinates == true
    % Load controller output
    Coord = load(strcat(sub,'\sim_XY_worldcoordinates.mat'));
    %Coord_time = Coord.sim_XY_worldcoordinates.Time';
    Coord_data = Coord.sim_XY_worldcoordinates.signals.values';  
    
    fig.Pos_Global = figure('Name','Position Worldframe','NumberTitle','off');
    
    plot(Coord_data(1,:),Coord_data(2,:),'b')
    grid on
    title('Position XY','Interpreter','latex')
end 


% Clear all loaded values
clear T_state T_state_data T_state_time M_state M_state_data M_state_time ...
E_state E_state_data E_state_time TS_state TS_state_data TS_state_time...
ES_state ES_state_data ES_state_time C_out C_out_time C_out_data Coord ...
Coord_time Coord_data
end

