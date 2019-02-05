% This script plots the generated outputs from the simulation
disp('--------------------------------------------------------')

% Set this to the simulation folder to plot
folderIndex = 9; 

% Save plots
save_plots = false;

% Close figures after save?
close_figures = true;

% Directory of the saved simulation data
folderName = "saved_simulation_results";
subName = strcat(folderName, '\\simulation', num2str(folderIndex));
disp(['The amount of simulation results are ',num2str(size(dir(folderName),1)-2)])
disp('')
if ~exist(subName,'dir')
    disp(['You have chosen folder ',num2str(folderIndex)])
    disp('-----------------That folder does not exist-------------------')
    disp(['The plot will take the latest simulation data from folder ',num2str(size(dir(folderName),1)-2)])
    folderIndex = num2str(size(dir(folderName),1)-2);    
    subName = strcat(folderName, '\\simulation', num2str(folderIndex));
end

disp(['The data from the folder simulation',num2str(folderIndex),' will be plotted'])



%What to be plotted, ONLY TRUE OR FALSE VALUES
angles = true;                       % True state
angular_velocity = true;             % True state
velocity = true;                     % True state
estimated_angles = true;            % Estimated state
estimated_angular_velocity = true;  % Estimated state
estimated_velocity = true;           % Estimated state
measured_angles = true;              % Measured state
measured_angular_velocity = true;    % Measured state
measured_velocity = true;            % Measured state

compare_true_vs_measured = true;     % Compare states
compare_true_vs_estimated = true;    % Compare states

estimated_state_error = true;        % Estimated state error
true_state_error = true;             % True state error

control_output = true;               % Controller output
XY_Coordinates = true;               % Global coordinates

setpoint_tracking = true;

deg = true;                         % Unit, degrees

fig = plotdata(subName, angles, angular_velocity, velocity,estimated_angles,...
    estimated_angular_velocity, estimated_velocity,...
    measured_angles, measured_angular_velocity,...
    measured_velocity, compare_true_vs_measured,...
    compare_true_vs_estimated, estimated_state_error,...
    true_state_error, control_output, XY_Coordinates,setpoint_tracking,deg);

% fig is a struct of all outputted figures


% Save figures as PNG and EPS

if save_plots
    fields = fieldnames(fig);
    plotdir = strcat(subName,'\\plots');
    if ~exist(plotdir,'dir')
        mkdir(plotdir);
    end
    
    fprintf("Saving plots...\n");
    for i = 1:numel(fields)
        f = fig.(fields{i});
        saveas(f, strcat(plotdir,'\\',fields{i}),'png');
        saveas(f, strcat(plotdir,'\\',fields{i}),'epsc');
        fprintf("(%d/%d) Saved %s\n",i,numel(fields),fields{i});
    end
    fprintf("Done saving\n");
    if close_figures
        fprintf("Closing figures...\n");
        close all
        fprintf("Done\n");
    end
end








