folderIndex = 1;
folderName = "saved_simulation_results";

if ~exist(folderName,'dir')
    mkdir(folderName);
end

subName = strcat(folderName, '\\simulation', num2str(folderIndex));
while exist(subName,'dir')
    folderIndex = folderIndex + 1;
    subName = strcat(folderName, '\\simulation', num2str(folderIndex));
end

mkdir(subName);
save(strcat(subName,'\\sim_angles.mat'),'sim_angles');
save(strcat(subName,'\\sim_tracking.mat'),'sim_tracking');
save(strcat(subName,'\\sim_XY_worldcoordinates.mat'),'sim_XY_worldcoordinates');
save(strcat(subName,'\\sim_measured_state.mat'),'sim_measured_state');
save(strcat(subName,'\\sim_true_state.mat'),'sim_true_state');
save(strcat(subName,'\\sim_estimated_state.mat'),'sim_estimated_state');
save(strcat(subName,'\\sim_control_output.mat'),'sim_control_output');
save(strcat(subName,'\\sim_estimated_state_error.mat'),'sim_estimated_state_error');
save(strcat(subName,'\\sim_true_state_error.mat'),'sim_true_state_error');




