function v = testTrajectory(t)

t_case = 2;
v0 = 3.5;

switch t_case
    case 1
        if t < 10
            v = v0;
        elseif t >= 10 && t < 20
            v = v0 - v0/10*(t-10);
        else
            v = 0;
        end
    case 2
        if t < 15
            v = v0;
        elseif t < 35
            v = v0 - v0/20*(t-20);
        else
            v = 0;
        end
    otherwise
        v = v0;
end