function zeta_field(mt)
% this function plots the zeta function given a maximum computational time

rinit=1; rfinal=10;
iinit=-5; ifinal=5;

[x,y] = meshgrid(linspace(rinit, rfinal), linspace(iinit, ifinal));
C_plane = x+1i*y;
my_z = zeros(100);

tic
s = 1;
while toc<mt
    
    my_z = my_z + s.^-(C_plane);
    
    s = s + 1;
end

for j=1:100
    for k=1:100
        my_z(j,k) = abs(my_z(j,k));
    end
end

surf(my_z)
