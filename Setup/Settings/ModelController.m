%% Static LQR

A_temp = [
    0 1 0 0 0
    parameters.g/bike.height -parameters.constV.^2/(bike.height*bike.wheelbase) 0 -bike.rearlength*parameters.constV/(bike.height*bike.wheelbase) 0
    0 0 0 1 0
    0 0 0 0 0
    0 0 0 0 0
];
controller.K = lqr(...
        A_temp,...
        state_space.B,...
        controller.Q,...
        controller.R);

    
%% Dynamic LQR for roll control

v = linspace(controller.vmin, controller.vmax, controller.Npoints);

K_lookup = zeros(size(state_space.B,2),size(state_space.A,2),controller.Npoints);
controller.K_lookup = zeros(size(state_space.B,2)*controller.Npoints,size(state_space.A,2));

for i = 1:controller.Npoints
    A_temp = [
        0 1 0 0 0
        parameters.g/bike.height -v(i).^2/(bike.height*bike.wheelbase) 0 -bike.rearlength*v(i)/(bike.height*bike.wheelbase) 0
        0 0 0 1 0
        0 0 0 0 0
        0 0 0 0 0
    ];
    K_lookup(:,:,i) = lqr(...
        A_temp,...
        state_space.B,...
        controller.Q,...
        controller.R);
    
    controller.K_lookup(2*i-1:2*i,:) = K_lookup(:,:,i);
end

createKlookupFunction(K_lookup);

clear K_lookup i v A_temp



