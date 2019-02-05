N = controller.Npoints;
v = linspace(controller.vmin, controller.vmax, N);


[n,m] = size(state_space.A);
state_space.A_lookup = zeros(n*N,m);

%warning('ModelObserver.m [Line 9]: L_lookup size is not dynamic');
observer.L_lookup = zeros(N*5,5);

B = state_space.B;
C = state_space.C;
D = state_space.D;
R = observer.R;
Q = observer.Q;

options = optimoptions('fsolve','Display','none');

for i = 1:controller.Npoints
    A = [
        0 1 0 0 0
        parameters.g/bike.height -v(i).^2/(bike.height*bike.wheelbase) 0 -bike.rearlength*v(i)/(bike.height*bike.wheelbase) 0
        0 0 0 1 0
        0 0 0 0 0
        0 0 0 0 0
    ];
    state_space.A_lookup((i-1)*n+1:i*n,:) = A;
    
    ric = @(P) (A*P*A.' - A*P*C.'/(C*P*C.' + R)*C*P*A.' + Q) - P;
    P = fsolve(ric,eye(n),options);
    L = P*C.'/(C*P*C.' + R);
    observer.L_lookup((i-1)*n+1:i*n,:) = L;
end

clear A B C D i L m n N options P Q R ric v

