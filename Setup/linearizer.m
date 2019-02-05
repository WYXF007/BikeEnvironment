clc
close all
clear variables


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

dynamics = [
    dd_theta == g/h*sin(theta) - a*v/(h*b)*d_delta - v^2/(h^2*b)*delta
    dv == 1/(m*d)*T
];

dx = [
    d_theta
    g/h*theta - a*v/(h*b)*d_delta - v^2/(h^2*b)*delta % theta ~=~ sin(theta) theta ~=~ 0
    d_delta
    dd_delta
    1/(m*d)*T
];


A = jacobian(dx,x);
B = jacobian(dx,u);

pretty(A);
pretty(B);

linearization_point = [
    0
    0
    0
    0
    3
];

A = subs(A,[theta,d_theta,delta,d_delta,v].',linearization_point)
B = subs(B,[theta,d_theta,delta,d_delta,v].',linearization_point)




