clc; clear; close all;
%% dati
% modello
z0n = 3; % altezza standard snow
z0z = 2; % altezza media

anz = 5e-1; % quanta neve si crea sopra altitudine soglia (z0n)
azz = 5e-3; % di quanto la montagna si alza da sola per movimenti sismici
azw = 5e-3; % di quanto si erode per l'acqua
awn = 5; % quanta acqua diventa neve
aww = 3; % quanta acqua esce dal sistema per evaporazione - movimento

dndt = @(n,z,w) anz*(z - z0n);
dzdt = @(n,z,w) azz*(z + z0z) - azw*w*z;
dwdt = @(n,z,w) awn*n - aww*w;

dnzwdt = @(n,z,w) [dndt(n,z,w);
                   dzdt(n,z,w);
                   dwdt(n,z,w)];

%% griglie
% temporale
tend = 100;
dt = tend/1e4;
time = (0:dt:tend)';
mm = length(time);

% vettori [neve; altitudine; water]
nzw = zeros(3,mm);

% boundary conditions
nzw(:,1) = [0.7;z0n;1];

%% loop (FE)
for inst = 2:mm
    nzw(:,inst) = nzw(:,inst-1) + dt*dnzwdt(nzw(1,inst-1),nzw(2,inst-1),nzw(3,inst-1));
end

%% post production
figure('Renderer', 'painters', 'Position', [100 100 900 600])
hold on
plot(time,nzw(1,:),'k-','linewidth',2,'DisplayName','Snow')
plot(time,nzw(2,:),'r-','linewidth',2,'DisplayName','Altitudine')
plot(time,nzw(3,:),'b-','linewidth',2,'DisplayName','Water')

plot([0 time(mm)],[z0n z0n],'k-.','linewidth',1.5,'DisplayName','Linea neve')
plot([0 time(mm)],[z0z z0z],'r-.','linewidth',1.5,'DisplayName','Altitudine media')

title('Montagne')
xlabel('Tempo')
ylabel('Qta')
grid on
box on
legend('location','northeastoutside')
set(gca,'fontsize',18)