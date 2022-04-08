function [] = print_parallel_equivalent(f,Z)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
w=2*pi*f;
Y=1./Z;
Rp=1/real(Y);
Xp=-1/imag(Y);
if(imag(Z)<0)
    Cp=imag(Y)./w;
    fprintf('At f=%.3f MHz, Z = %.3f + j%.3f ohm, or %.3f || j%.3f, (Cp=%.3f pF)\n',f/1e6,real(Z),imag(Z),Rp,Xp,Cp*1e12);
else
    Lp=Xp./(w);
    fprintf('At f=%.3f MHz, Z = %.3f + j%.3f ohm, or %.3f || j%.3f, (Lp=%.3f nH)\n',f/1e6,real(Z),imag(Z),Rp,Xp,Lp*1e9);
end
    
end

