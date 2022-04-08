function [] = print_series_equivalent(f,Z)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
w=2*pi*f;
if(imag(Z)<0)
    Cs=-1./(imag(Z)*w);
    ESR=real(Z);
    fprintf('At f=%.3f MHz, Z = %.3f + j%.3f ohm (C=%.3f pF)\n',f/1e6,real(Z),imag(Z),Cs*1e12);
else
    Ls=imag(Z)./(w);
    ESR=real(Z);
    fprintf('At f=%.3f MHz, Z = %.3f + j%.3f ohm (L=%.3f nH)\n',f/1e6,real(Z),imag(Z),Ls*1e9);
end
    
end

