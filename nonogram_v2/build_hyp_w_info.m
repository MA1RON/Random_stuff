function hyp = build_hyp_w_info(hyp,mm)

nn = size(hyp,2);
jjmax = find(hyp==0,1)-1; % !!! breaks if you use all the rows of hyp_w_task !!!

for kk = 1:nn
    hyp(hyp(1:jjmax,kk)~=mm(kk) & mm(kk),:) = [];
end

end