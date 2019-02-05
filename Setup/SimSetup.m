clear bike 
clear controller
clear model_settings
clear Noise
clear observer
clear parameters
clear position_model
clear state_space

format short

addpath('./Setup/Settings/')

ModelSettings
ModelParams
ModelStateSpace
ModelEKF              % Ivar added a EKF modelling script
ModelPosition         % This is empty
ModelController
ModelObserver


% Save one file with everything
save('modelconfig.mat',...
    'model_settings',...
    'parameters',...
    'controller',...
    'bike',...
    'state_space'...
    );

% Also save some individual files, for easy access during runtime
save('bike.mat','bike');