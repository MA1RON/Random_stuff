function mm = update_MM(hyp,mm)

nn = length(mm);
jjmax = find(hyp==0,1)-1; % !!! breaks if you use all the rows of hyp_w_info !!!

for kk = 1:nn
    if all(hyp(1,kk)==hyp(2:jjmax,kk))
        mm(kk) = hyp(1,kk);
    end
end

end