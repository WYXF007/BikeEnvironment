clc
close all
clear variables

s1 = {
    'saved_simulation_results\\x0_3deg_1mps'
    'saved_simulation_results\\x0_6deg_1mps'
};

s2 = {
    'saved_simulation_results\\x0_6deg_2mps'
    'saved_simulation_results\\x0_12deg_2mps'
    'saved_simulation_results\\x0_24deg_2mps'
};


d11 = load(strcat(s1{1},'\\sim_tracking'));
d12 = load(strcat(s1{2},'\\sim_tracking'));

d21 = load(strcat(s2{1},'\\sim_tracking'));
d22 = load(strcat(s2{2},'\\sim_tracking'));
d23 = load(strcat(s2{3},'\\sim_tracking'));


deg = @(r) r*180/pi;

fontsize = 25;

%%
bigfig; hold on;
plot(...
    d11.sim_tracking.time,...
    deg(d11.sim_tracking.signals.values(:,1:2)),...
    'LineWidth',1.5);

plot(...
    d12.sim_tracking.time,...
    deg(d12.sim_tracking.signals.values(:,2)),...
    'LineWidth',1.5);

title('Recovery: v = 1 m/s');
xlabel('time [s]');
ylabel('roll angle [deg]');
L = legend('reference','$\theta_0 \approx 3\ deg$','$\theta_0 \approx 6\ deg$','interpreter','latex','location','best');
L.FontSize = fontsize;
axis([0 15 -10 100]);

%%
bigfig; hold on;
LineWidth = 2;
plot(...
    d21.sim_tracking.time,...
    deg(d21.sim_tracking.signals.values(:,1:2)),...
    'LineWidth',LineWidth);

plot(...
    d22.sim_tracking.time,...
    deg(d22.sim_tracking.signals.values(:,2)),...
    'LineWidth',LineWidth);
plot(...
    d23.sim_tracking.time,...
    deg(d23.sim_tracking.signals.values(:,2)),...
    'LineWidth',LineWidth);

title('Recovery: v = 2 m/s');
xlabel('time [s]');
ylabel('roll angle [deg]');
L = legend('reference','$\theta_0 \approx 6\ deg$','$\theta_0 \approx 12\ deg$','$\theta_0 \approx 24\ deg$','interpreter','latex','location','best');

L.FontSize = fontsize;

axis([0 15 -10 100]);


%%

range1 = d11.sim_tracking.time < 5;
range2 = d12.sim_tracking.time < 5;
range3 = d21.sim_tracking.time < 6;
range4 = d22.sim_tracking.time < 6;
range5 = d23.sim_tracking.time < 6;

bigfig;
LineWidth = 2;
subplot(2,1,1);
hold on;
plot(...
    d11.sim_tracking.time(range1),...
    deg(d11.sim_tracking.signals.values(range1,1:2)),...
    'LineWidth',LineWidth);

plot(...
    d12.sim_tracking.time(range2),...
    deg(d12.sim_tracking.signals.values(range2,2)),...
    'LineWidth',LineWidth);

title('Recovery: v = 1 m/s');
xlabel('time [s]');
ylabel('roll angle [deg]');
L = legend('reference','$\theta_0 \approx 3\ deg$','$\theta_0 \approx 6\ deg$','interpreter','latex','location','best');
L.FontSize = fontsize;
axis([0 5 -10 100]);

subplot(2,1,2);
hold on;

plot(...
    d21.sim_tracking.time(range3),...
    deg(d21.sim_tracking.signals.values(range3,1:2)),...
    'LineWidth',LineWidth);

plot(...
    d22.sim_tracking.time(range4),...
    deg(d22.sim_tracking.signals.values(range4,2)),...
    'LineWidth',LineWidth);
plot(...
    d23.sim_tracking.time(range5),...
    deg(d23.sim_tracking.signals.values(range5,2)),...
    'LineWidth',LineWidth);

title('Recovery: v = 2 m/s');
xlabel('time [s]');
ylabel('roll angle [deg]');
L = legend('reference','$\theta_0 \approx 6\ deg$','$\theta_0 \approx 12\ deg$','$\theta_0 \approx 24\ deg$','interpreter','latex','location','best');

L.FontSize = fontsize;

axis([0 6 -10 100]);


