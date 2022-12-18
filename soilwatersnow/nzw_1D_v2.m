clc; clear; close all;
%% dati
kz = 1e-1; % conducibilità altitudine
kw = 1; % conducibilità water

% modello
z0n = 3; % altezza standard snow

anz = 5e-1; % quanta neve si crea sopra altitudine soglia (z0n)
azz = 5e-3; % di quanto la montagna si alza da sola per movimenti sismici
azw = 1e-3; % di quanto si erode per l'acqua
awn = 5e-1; % quanta acqua diventa neve
aww = 3e-2; % quanta acqua esce dal sistema per evaporazione

%% griglie
% temporale
tend = 5e3;
dt = tend/1e4;
time = (0:dt:tend)';
mm = length(time);

% spaziale
xend = 50;
dx = xend/1e2;
xx = (0:dx:xend)';
NN = length(xx);

% vettori [neve; altitudine; water]
nn = zeros(NN,mm);
zz = zeros(NN,mm);
ww = zeros(NN,mm);

% boundary conditions
nn(:,1) = .7;
zz(:,1) = z0n*1.5 * exp(-.1*(xx-xend/3).^2) + z0n*2 * exp(-.6*(xx-xend*2/3).^2) + z0n/2;
ww(:,1) = 1;

%% operatori
d2dx2 = spdiags([ones(NN,1) -2*ones(NN,1) ones(NN,1)],-1:1,NN,NN)/dx^2;
% bc
d2dx2(1,1) = 1;
d2dx2(1,2) = 0;
d2dx2(end,end-1) = 0;
d2dx2(end,end) = 1;

dndt = @(n,z,w) anz*(z - z0n);
dzdt = @(n,z,w) azz*z - azw*w.*z + kz*d2dx2*z;
dwdt = @(n,z,w) awn*n - aww*w + kw*d2dx2*z;

%% loop (FE)
tol = 1e-2;
figure('Renderer', 'painters', 'Position', [100 100 900 600])
for inst = 2:mm
    nn(:,inst) = max(nn(:,inst-1) + dt*dndt(nn(:,inst-1),zz(:,inst-1),ww(:,inst-1)),0);
    zz(:,inst) = zz(:,inst-1) + dt*dzdt(nn(:,inst-1),zz(:,inst-1),ww(:,inst-1));
    ww(:,inst) = max(ww(:,inst-1) + dt*dwdt(nn(:,inst-1),zz(:,inst-1),ww(:,inst-1)),0);
    
    subplot(2,2,1)
    plot(xx,zz(:,inst),'r-','linewidth',2)
    ylim([-1 6])
    grid on
    box on
    set(gca,'fontsize',18)
    title('Altitudine')
    
    subplot(2,2,2)
    plot(xx,ww(:,inst),'b-','linewidth',2)
    ylim([0 100])
    grid on
    box on
    set(gca,'fontsize',18)
    title('Water')
    
    subplot(2,2,3)
    plot(xx,nn(:,inst),'k-','linewidth',2)
    ylim([0 40])
    grid on
    box on
    set(gca,'fontsize',18)
    title('Neve')

    drawnow
    
    if all(abs([nn(:,inst) zz(:,inst) ww(:,inst)] - [nn(:,inst-1) zz(:,inst-1) ww(:,inst-1)]) < tol)
        fprintf("Raggiunta condizione stazionaria.\n")
        break
    end
end

ninf = sum(nn(:,inst))/NN;
zinf = sum(zz(:,inst))/NN;
winf = sum(ww(:,inst))/NN;

nave = sum(nn,1)/NN;
zave = sum(zz,1)/NN;
wave = sum(ww,1)/NN;

nave = [nave(1:inst) ninf*ones(1,mm-inst)];
zave = [zave(1:inst) zinf*ones(1,mm-inst)];
wave = [wave(1:inst) winf*ones(1,mm-inst)];

%% post production
figure('Renderer', 'painters', 'Position', [100 100 900 600])
hold on
plot(time,nave,'k-','linewidth',2,'DisplayName','Snow')
plot(time,zave,'r-','linewidth',2,'DisplayName','Altitudine')
plot(time,wave,'b-','linewidth',2,'DisplayName','Water')

plot([0 time(mm)],[z0n z0n],'k-.','linewidth',1.5,'DisplayName','Linea neve')

title('Montagne - Tempo (media spaziale)')
xlabel('Tempo')
ylabel('Qta')
grid on
box on
legend('location','northeastoutside')
set(gca,'fontsize',18)