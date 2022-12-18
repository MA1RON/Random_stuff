clc; clear; close all;
% this function plots the pascal diamond overlapped at its continuous
% counterpart

startingn=0;
n=5;
z=1:n;
p=z;
p(2)=1/4;
for j=3:n
    
    p(j)=p(j-2)*2^(2-2*j);
    
end
f=@(x) 2.^-floor(x.^2/2);
fnf=@(x) 2.^-(x.^2/2);
r=startingn:0.1:n;

plot(z,p,'x',r,f(r),r,fnf(r))