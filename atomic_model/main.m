clc; clear; close all;
%% data
% physical quantities
data = readmatrix('data.csv');
EL = data(:,1:2);	% elements -> p | n

ll = data(:,3);     % decay constants
LL = dec_mat(EL);   % decay matrix

kk = data(:,4);     % capture constants Sigma_c*PHI/v
KK = cap_mat(EL);   % capture matrix

ff = data(:,5);     % fission constants Sigma_f*PHI/v
FF = fis_mat(ff,EL);% fission matrix - TO DO

SS = @(t) data(:,6)*abs(sin(t));% source

% time grid
TT = 10;
nt = 1e2;
dt = TT/nt;
tt = (dt:dt:TT)';

% concentration
ne = size(EL,1);   % number of elemets
CC0 = ones(ne,1);
CC = zeros(ne,nt);
CC(:,1) = CC0;

%% FE
for inst = 2:nt
    CC(:,inst) = CC(:,inst-1) +...
                 + LL* (ll.*CC(:,inst-1)) *dt +...
                 + KK* (kk.*CC(:,inst-1)) *dt +...
                 + FF* (ff.*CC(:,inst-1)) *dt + ...
                 + SS(tt(inst-1)) *dt;
end

%% pp
hold on
for sp = 1:ne
    plot(tt,CC(sp,:),'-','linewidth',2,...
        'DisplayName',[num2str(EL(sp,1)) '|' num2str(EL(sp,2))])
end
grid on
box on
set(gca,'fontsize',18)
xlabel('Time')
ylabel('Concentrations')
legend('location','northeastoutside')