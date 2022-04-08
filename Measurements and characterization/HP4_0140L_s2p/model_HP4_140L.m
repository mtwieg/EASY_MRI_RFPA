addpath('sbox/sbox');

 %{

---DCR1---LL1-------o---o---o---DCR2---LL2----
                    |   |   |
                    |   |   |
                    Cp  Lp  Rp
                    |   |   |
                    |   |   |
%}

Z0=50;
ftest=5.1e6;
% ftest=9e6;
% fprintf('\n')
% fprintf('*******************************************\n')
% %% port 1 is primary (4T), secondaries (1TCT) are shorted
% fprintf('port 1 is primary (4T), secondaries (1TCT) are shorted\n')
% baseline_filename='S2P_P1PRIMARY_P2NONE_SECONDARIESSHORTED.S2P';
% [f,S]=read_s2p(baseline_filename);
% [df test_idx]=min(abs(f-ftest));
% ftest=f(test_idx);
% S=squeeze(S(test_idx,:,:));
% Z=Z0*s2z(S); Z=Z(1,1);
% Z_primary_leakage=Z;
% fprintf('Z_primary_leakage:\n')
% print_series_equivalent(ftest,Z_primary_leakage)

fprintf('\n')
fprintf('*******************************************\n')
%% port 2 is secondary (pos side), other windings open
fprintf('secondary magnetizing impedance\n')
baseline_filename='S2P_P1NONE_P2SECP_SECNOPEN.S2P';
[f,S]=read_s2p(baseline_filename);
Z=Z0*s2z(permute(S,[3 2 1]));
Zs_mag=squeeze(Z(2,2,:));
% plot(f,real(Zs_mag),f,imag(Zs_mag));
%% get magnetizing inductance using lowest frequency data
Zs_mag_lowf=squeeze(Z(2,2,1));
lowf=f(1);
Lmag=imag(Zs_mag_lowf)./(2*pi*lowf);
DCR=real(Zs_mag_lowf);
fprintf('Low frequency: DCR = %.3f ohms, Lmag = %.3f uH\n',DCR,Lmag*1e6);
% print_series_equivalent(lowf,Zs_mag_lowf);
%% look for self resonance, peak magnitude impedance
[srf_Zs srf_idx]=max(abs(Zs_mag)); 
srf=f(srf_idx);
fprintf('SRF = %.3f MHz, peak Zmag=%.3f ohms\n',srf/1e6,srf_Zs);
Cp=1/((2*pi*srf)^2)/Lmag;
fprintf('Cp = %.2f pf\n',Cp*1e12);

fprintf('\n')
fprintf('*******************************************\n')
%% S2P_P1SECN_P2SECP_PRIOPEN
fprintf('coupling between single windings\n')
baseline_filename='S2P_P1SECN_P2SECP_PRIOPEN.S2P';
[f,S]=read_s2p(baseline_filename);
% winding polarities are opposite, so make S21 and S12 negative
S(:,1,2)=-S(:,1,2); S(:,2,1)=-S(:,2,1);
[df test_idx]=min(abs(f-ftest));
ftest=f(test_idx);
S=squeeze(S(test_idx,:,:));
Z=Z0*s2z(S); 
ZL1=Z(1,1)-Z(2,1);
ZL2=Z(2,2)-Z(2,1);
fprintf('primary leakage ZL1 = Z11-Z21\n')
print_series_equivalent(ftest,ZL1)
fprintf('secondary leakage ZL2 = Z22-Z21\n')
print_series_equivalent(ftest,ZL2)
fprintf('magnetizing impedance = Z21\n')
% print_series_equivalent(ftest,Z(2,1))
print_parallel_equivalent(ftest,Z(2,1))

fprintf('\n')
fprintf('*******************************************\n')
%% S2P_P1SECN_P2SECP_PRIOPEN
fprintf('four turn primary to single turn secondary\n')
baseline_filename='S2P_P1PRIMARY_P2SECN_SECPOPEN.S2P';
[f,S]=read_s2p(baseline_filename);
% winding polarities are opposite, so make S21 and S12 negative
S(:,1,2)=-S(:,1,2); S(:,2,1)=-S(:,2,1);
[df test_idx]=min(abs(f-ftest));
ftest=f(test_idx);
S=squeeze(S(test_idx,:,:));
Z=Z0*s2z(S); 
ZL1=Z(1,1)-Z(2,1);
ZL2=Z(2,2)-Z(2,1);
fprintf('primary leakage ZL1 = Z11-Z21\n')
print_series_equivalent(ftest,ZL1)
fprintf('secondary leakage ZL2 = Z22-Z21\n')
print_series_equivalent(ftest,ZL2)
fprintf('magnetizing impedance = Z21\n')
% print_series_equivalent(ftest,Z(2,1))
print_parallel_equivalent(ftest,Z(2,1))
return;
Z=Z(1,1);
Z_primary_leakage=Z;
fprintf('Z_primary_leakage:\n')
print_series_equivalent(ftest,Z_primary_leakage)