function FF = fis_mat(ff,EL)
nel = size(EL,1);
FF = eye(nel);
yield = readmatrix('fis_yield.csv');

for el = 1:nel
    if ff(el) % does fission
        proton = EL(el,1); neutron = EL(el,2);
        fis_el = yield(:,1) == proton & yield(:,2) == neutron;
        FF(el,:) = yield(fis_el,3:end);
        FF(el,el) = -1;
    end
end
FF = FF';