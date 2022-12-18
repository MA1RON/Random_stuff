% this script simulates the behaviour of particles in a gravity field
clc; clear; close all;
%% dati
GG = 1e-2;
MM = 1e3;

LL = 50;

np = 5;

mm = rand(1,np);

nearfactor = 2;
x0 = (rand(1,np)-.5)*2*LL/nearfactor;
y0 = (rand(1,np)-.5)*2*LL/nearfactor;
% x0 = -5;
% y0 = -7;
slowfactor = 1e2;
vx0 = (rand(1,np)-.5)*2*LL/nearfactor/slowfactor;
vy0 = (rand(1,np)-.5)*2*LL/nearfactor/slowfactor;
% vx0 = -.5;
% vy0 = .5;

%% griglia tempo
tend = 5e1;
% dt = tend/5e3;
dt = tend/5e2;
time = (0:dt:tend)';
lt = length(time);

%% loop
pp = zeros(lt,2,np); % x, y
vv = zeros(lt,2,np); % vx, vy
crash = zeros(lt,2,np);
pp(1,:,:) = [x0; y0];
vv(1,:,:) = [vx0; vy0];

% TODO
% PER METTERE L'INTERAZIONE TRA LORO STESSE DOVREI METTERE DUE FOR E
% CALCOLARE OGNI DV RISPETTO AD OGNI ALTRA, RR2 RISPETTO ALL'ALTRA E
% RISPETTO A 0 PER LA CENTRALE CC RISPETTO ALLA MASSA DELL'ALTRA
% ANCHE GLI ANGOLI CALCOLATI RISPETTO ALLA NUOVA ORIGINE
dmin = 2;
for inst = 2:lt
    rr2(1:np) = sum(pp(inst-1,:,:).^2,2);
    theta(1:np) = atan(pp(inst-1,2,:)./pp(inst-1,1,:));
    signfactor(1:2,1:np) = sign(pp(inst-1,:,:));
    cc(1:np) = -GG*MM./rr2;
    angle = [abs(cos(theta))', abs(sin(theta))'].*signfactor';
    dv(1,1:2,1:np) = reshape((dt*[cc', cc'].*angle)',1,2,np);
    crash(inst,1:2,1:np) = [(rr2(:)>dmin), (rr2(:)>dmin)]';
    vv(inst,:,:) = (vv(inst-1,:,:) + dv).*crash(inst,:,:);
    pp(inst,:,:) = pp(inst-1,:,:) + vv(inst,:,:);
end

%% pp
inst = 1;
hold on
set(gca,'fontsize',16)
plot(0,0,'ko','markersize',20,'markerfacecolor','k')
while inst <= lt
    for jp = 1:np
        plot(pp(inst,1,jp),pp(inst,2,jp),'ko','markersize',8,'markerfacecolor',[jp/np 1-jp/np 0])
    end
    xlim([-LL LL])
    ylim([-LL LL])
    grid on
    box on
    title([num2str(time(inst),'t = %.2f') num2str(np-sum(crash(inst,1,:)),'...crash = %i')])
    drawnow
    
    inst = inst +1;
end