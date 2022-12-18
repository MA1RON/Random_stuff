function hyp = build_hyp_tot(nn)

hyp = dec2bin(0:2^(nn)-1)-'0';

hyp(hyp==0) = hyp(hyp==0)-1;

end