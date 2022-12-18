% simulates Lodka Volterra but with one super predator that can eat the
% predator and can't be eaten
clc; clear; close all;
%% parametri
fairfactor = 10;
amin = 40; amax = 60;
a12 = randi([amin amax])/1e3;
a13 = randi([amin amax])/1e3;
a23 = randi([amin amax])/1e3/fairfactor; % se no sfavorisco troppo 2
coeff = [1, -a12, -a13;...
         a12*2, -1, -a23;...
         a13*2, a23*2, -1];
sys = @(x,y,z) [x, x*y, x*z;...
                y*x, y, y*z;
                z*x, z*y, z];

tend = 15;
init = randi(50,1,3);

dldt = @(x,y,z) sum(coeff.*sys(x,y,z),2);

%% griglia
% tempo
mm = 1+1e3;
dt = tend/(mm-1);
tt = (0:dt:tend)';

%% transitorio
life = zeros(size(coeff,1), mm);
life(:, 1) = init;

for inst = 2:mm
    life(:, inst) = life(:, inst-1) + dt*dldt(life(1,inst-1), life(2,inst-1), life(3, inst-1));
end

%% post production
hold on
set(gca,'fontsize',18)
grid on
box on
xlabel('time')
ylabel('# individuals')
title(['a_{12} = ' num2str(a12*1e1,'%.2f'),...
       ' a_{13} = ' num2str(a13*1e1,'%.2f'),...
       ' a_{23} = ' num2str(a23*1e1,'%.2f')])
legend('location','northeastoutside')

plot(tt,life(1,:),'b-','linewidth',2, 'DisplayName','Prey')
plot(tt,life(2,:),'r-','linewidth',2, 'DisplayName','Predator')
plot(tt,life(3,:),'k-','linewidth',2, 'DisplayName','Super Predator')