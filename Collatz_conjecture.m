% visual rapresentation of Collatz conjecture
mm = 10000;

figure(1)
hold on
grid on
box on
set(gca,'fontsize',18)

last_jj = [];

for n0 = 1:mm
    
    nn = n0;
    jj = 1;
    while nn > 1
        jj = jj+1;
        if mod(nn(jj-1),2) == 0 % pari
            nn(jj) = nn(jj-1)/2;
        else % dispari
            nn(jj) = 3*nn(jj-1)+1;
        end
    end
    last_jj(n0) = jj;
    
    plot(1:jj,nn,'.-','Color',[n0/mm 1-n0/mm 0],'markersize',3)
end

figure(2)
hold on
grid on
box on
set(gca,'fontsize',18)
scatter(1:mm,last_jj,'o')