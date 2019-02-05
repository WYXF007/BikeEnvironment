function R = rotz(angle)
R = [
    cosd(angle) -sind(angle) 0 
    sind(angle) cosd(angle) 0
    0 0 1
];