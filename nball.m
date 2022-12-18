% this script plots the surface and volume of balls of n-dimensions, with n
% varying
v0 = 1;
s0 = 2;
RR = 1;

max_dimensions = 20; % più la 0

vv = zeros(max_dimensions+1, 1);
ss = zeros(max_dimensions+1, 1);

for dimension = 0:max_dimensions
    if dimension == 0
        vv(1) = v0;     % dimensione 0
        ss(1) = s0;     % dimensione 0
    else
        mio_indice = dimension+1;
        ss(mio_indice-1) = 2*pi^(dimension/2)/(gamma(dimension/2))*RR^(dimension-1);
        vv(mio_indice) = pi^(dimension/2)/(gamma(dimension/2+1))*RR^dimension;
    end
end


yyaxis left
plot(0:max_dimensions, vv,'r-.o') % volume
ylabel('Volume V_n')
yyaxis right
plot(0:max_dimensions,([0; ss(1:end-1)])','b-.o') % surface
ylabel('Superficie S_n_-_1')
grid on
box on
legend('Volume', 'Surfacie')
xlabel('Dimensioni')
set(gca, 'fontsize', 18)
ax = gca;
ax.YAxis(1).Color = 'r';
ax.YAxis(2).Color = 'b';