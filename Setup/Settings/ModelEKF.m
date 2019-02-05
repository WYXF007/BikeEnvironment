%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This script generates the necessary functions   %
%   and covariance matrices to construct the EKF    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Noise Covariance EKF

% A workaround to be able to use the EKF is including u in the statespace
% which removes alot of annoying errors, the discretized statespace then
% assumes that the next u estimate is the same as before.

syms theta d_theta delta d_delta dd_delta v T real
syms g h a b d m real

x = [theta;d_theta;delta;d_delta;v;dd_delta;T];

dx = [d_theta;...
    g/h*theta - (delta*v^2)/(b*h) - a/(b*h)*d_delta*v;...
    d_delta;...
    dd_delta;...
    T/(d*m);...
    0;...
    0];

DiscreteTransferMatrix = x + dx*parameters.Ts;
DiscreteTransferMatrixJacobian = jacobian(DiscreteTransferMatrix,x);

lin_val = [parameters.g; bike.height; bike.rearlength; bike.wheelbase; bike.diamW1; bike.mass];

DiscreteTransferMatrix = vpa(subs(...
    DiscreteTransferMatrix,...
    [g;h;a;b;d;m],...
    lin_val...
));

DiscreteTransferMatrixJacobian = vpa(subs(...
    DiscreteTransferMatrixJacobian,...
    [g;h;a;b;d;m],...
    lin_val...
));

EKF.Function.StateTrans = matlabFunction(DiscreteTransferMatrix,'File','EKF_TransferFcn','Vars',{x});
EKF.Function.JacobianTrans = matlabFunction(DiscreteTransferMatrixJacobian,'File','EKF_TransferFcnJacobian','Vars',{[delta;d_delta;v]});

% Initial point
EKF.InitialPoint = [state_space.x0;...
                    0;...
                    0];

% Initial uncertainity (+- sqrt(value))
Init_cov_theta = 0.5;
Init_cov_d_theta = 0.1;
Init_cov_delta = 0.5;
Init_cov_d_delta = 0.1;
Init_cov_v = 1;
Init_cov_dd_delta = 1;
Init_cov_T = 1;

EKF.Noise.InitialPoint = [Init_cov_theta; Init_cov_d_theta; Init_cov_delta;...
    Init_cov_d_delta; Init_cov_v; Init_cov_dd_delta; Init_cov_T];

% Process Noise 
Pros_cov_theta = 0.1;
Pros_cov_d_theta = 0.01;
Pros_cov_delta = 0.1;
Pros_cov_d_delta = 0.01;
Pros_cov_v = 0.5;
Pros_cov_dd_delta = 0.001;   
Pros_cov_T = 0.001;

EKF.Noise.stateEstimate = diag([Pros_cov_theta,Pros_cov_d_theta,Pros_cov_delta,...
                                Pros_cov_d_delta,Pros_cov_v,Pros_cov_dd_delta,Pros_cov_T]);

% Measurement Noise 
Meas_cov_theta = 0.1;
Meas_cov_d_theta = 0.01;
Meas_cov_delta = 0.1;
Meas_cov_d_delta = 0.01;
Meas_cov_v = 0.5;
Meas_cov_dd_delta = 0.001;   
Meas_cov_T = 0.001;

EKF.Noise.measurement = diag([Meas_cov_theta; Meas_cov_d_theta;...
    Meas_cov_delta; Meas_cov_d_delta; Meas_cov_v; Meas_cov_dd_delta;...
    Meas_cov_T]);


clear theta d_theta delta d_delta dd_delta v T g h a b d m 

clear DiscreteTransferMatrix DiscreteTransferMatrixJacobian lin_val 

clear Init_cov_theta Init_cov_d_theta Init_cov_delta Init_cov_d_delta
clear Init_cov_v Init_cov_dd_delta Init_cov_T

clear Pros_cov_theta Pros_cov_d_theta Pros_cov_delta Pros_cov_d_delta 
clear Pros_cov_v Pros_cov_dd_delta Pros_cov_T 

clear Meas_cov_theta Meas_cov_d_theta Meas_cov_delta Meas_cov_d_delta 
clear Meas_cov_v Meas_cov_dd_delta Meas_cov_T
