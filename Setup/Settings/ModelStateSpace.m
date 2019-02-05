
%% OLD: Remove once "new" is verified"
state_space.A = [
    0 1 0 0 0
    parameters.g/bike.height -parameters.constV.^2/(bike.height*bike.wheelbase) 0 -bike.rearlength*parameters.constV/(bike.height*bike.wheelbase) 0
    0 0 0 1 0
    0 0 0 0 0
    0 0 0 0 0
];

state_space.B = [ 
    0 0 
    0 0
    0 0
    1 0
    0 1
];

state_space.C = eye(size(state_space.A));
state_space.D = zeros(size(state_space.A,1),size(state_space.B,2));

%% NEW

syms theta d_theta dd_theta 
syms delta d_delta dd_delta
syms g h a b v dv T m d

x = [
    theta
    d_theta
    delta
    d_delta
    v
];

u = [
    dd_delta
    T
];

dx = [
    d_theta
    g/h*theta - a*v/(h*b)*d_delta - v^2/(h*b)*delta % theta ~=~ sin(theta) theta ~=~ 0
    d_delta
    dd_delta
    1/(m*d)*T
];

A = jacobian(dx,x);
B = jacobian(dx,u);

lin_val = [parameters.g; bike.height; bike.rearlength; bike.wheelbase; bike.diamW1; bike.mass; state_space.linearization_point];
A = double(vpa(subs(...
    A,...
    [g;h;a;b;d;m;theta;d_theta;delta;d_delta;v],...
    lin_val...
)));

B = double(vpa(subs(...
    B,...
    [g;h;a;b;d;m;theta;d_theta;delta;d_delta;v],...
    lin_val...
)));

state_space.A = A;
state_space.B = B;
state_space.C = eye(size(state_space.A));
state_space.D = zeros(size(state_space.A,1),size(state_space.B,2));

clear a A A_temp b B d d_delta dd_delta theta d_theta dd_theta g h m
clear lin_val T u v x dv dx delta

