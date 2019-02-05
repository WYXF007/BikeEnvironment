close all
bike = bike3D();
bike.SteerAngle = pi/3;
bike.TiltAngle = pi/6;
bike.updateRotations();
bike.draw();

n = 100;
a = linspace(0,pi/2,n);

for i = 1:n
    pause(0.01);
    bike.SteerAngle = -a(i);
    bike.TiltAngle = a(i);
    bike.updateRotations();
    bike.draw();
end

%%
clc
bike = bike3D();
bike.fromFile('sim_angles.mat');