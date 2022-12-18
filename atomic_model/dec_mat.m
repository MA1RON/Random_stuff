function LL = dec_mat(EL)

nel = size(EL,1);
LL = zeros(nel);

tol = .1;
for el = 1:nel
    proton = EL(el,1); neutron = EL(el,2); mass = proton + neutron;
    if neutron/proton > 1 + 0.0154*mass^(2/3) + tol
        % beta meno
        LL(el,EL(:,1) == proton+1 & EL(:,2) == neutron-1) = 1;
        LL(el,EL(:,1) == proton & EL(:,2) == neutron) = -1;
    elseif neutron/proton < 1 + 0.0154*mass^(2/3) - tol
        % beta più
        LL(el,EL(:,1) == proton-1 & EL(:,2) == neutron+1) = 1;
        LL(el,EL(:,1) == proton & EL(:,2) == neutron) = -1;
    else
        % stable
        LL(el,EL(:,1) == proton & EL(:,2) == neutron) = 1;
    end
end
LL = LL';