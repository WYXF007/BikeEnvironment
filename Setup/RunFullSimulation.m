clc
close all
clear variables


animation_length = 20;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%        SAVE ???        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prompt = questdlg('Save result after simulation?','Save');
auto_save = strcmp(prompt,'Yes');

% model_name = 'model_nonlinear_bike_closed_loop';
model_name = 'trajectory_p';


fprintf("--------------------------------------------\n");
fprintf("Starting simulation...\n");
% Run the setup script

tic
fprintf("\tSetup...");
SimSetup;
fprintf(" done\n");
tSetup = toc;



% Run the simulation
try
    timeout = 120;
    
    fprintf("\tRunning simulation...(timeout after %d seconds)",timeout);
    
    warning('off','all');
    simOut = sim(...
        model_name,...
        'timeout',timeout,...
        'CaptureErrors','on');
    warning('on','all');
    
    
    
    fprintf(" completed successfully\n");
    
    
    
catch e
    fprintf(1,'\nThe identifier was:\n%s',e.identifier);
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    %fprintf("\n\tThere was an error while running the simulation\n");
end

sim_XY_worldcoordinates = simOut.sim_XY_worldcoordinates;
sim_angles = simOut.sim_angles;
sim_control_output = simOut.sim_control_output;
sim_estimated_state = simOut.sim_estimated_state;
sim_estimated_state_error = simOut.sim_estimated_state_error;
sim_measured_state = simOut.sim_measured_state;
sim_tracking = simOut.sim_tracking;
sim_true_state = simOut.sim_true_state;
sim_true_state_error = simOut.sim_true_state_error;
sim_est_position = simOut.sim_est_position;

tSim = toc;

if auto_save
    % Save the results
    fprintf("\tSaving simulation results and plots...\n");
    SaveLastSimAndPlots;
    tSave = toc;
    
    
    
end

fprintf("\n\nSimulation completed!\n");
fprintf("\tTime elapsed\n");
fprintf("\t\tSetup: %.2f seconds\n",tSetup);
fprintf("\t\tSimulation: %.2f seconds\n",tSim-tSetup);
if auto_save
    fprintf("\t\tSaving: %.2f seconds\n",tSave-tSim);
end


% Animate?
prompt = questdlg('Show animation?','Animate?');
anim = strcmp(prompt,'Yes');

if (anim)
    addpath('3D Model');
    b = bike3D();
    b.fromData(sim_true_state);
end


