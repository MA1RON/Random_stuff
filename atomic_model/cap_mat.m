function KK = cap_mat(EL)
nel = size(EL,1);
KK = zeros(nel);

for el = 1:nel
    proton = EL(el,1); neutron = EL(el,2);
    KK(el,EL(:,1) == proton & EL(:,2) == neutron+1) = 1;
    KK(el,EL(:,1) == proton & EL(:,2) == neutron) = -1;
end
KK = KK';