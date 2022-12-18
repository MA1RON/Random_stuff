function [uu,vv,MM] = make_vectors(nn)

MM = randi(2,nn,nn)-1;
ll = ceil(nn/2);

uu = zeros(ll,nn);
vv = zeros(ll,nn);

%% left to right (uu)
for row = 1:nn
    hmn = 1; increasing = 0;
    for col = 1:nn
        if MM(col,row)==1
            uu(hmn,row) = uu(hmn,row) + 1;
            increasing = 1;
        elseif increasing
            hmn = hmn + 1;
            increasing = 0;
        end
    end
end

%% up to down (vv)
for col = 1:nn
    hmn = 1; increasing = 0;
    for row = 1:nn
        if MM(col,row)==1
            vv(hmn,col) = vv(hmn,col) + 1;
            increasing = 1;
        elseif increasing
            hmn = hmn + 1;
            increasing = 0;
        end
    end
end
end