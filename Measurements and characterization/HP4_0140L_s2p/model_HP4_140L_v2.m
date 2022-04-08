addpath('sbox/sbox');

clear singleturn_test primary secondary1 secondary2
singleturn_test.N=1;
singleturn_test.lowf_DCR=1;
singleturn_test.lowf_Lmag=1;
singleturn_test.ftest_Xp=1;
singleturn_test.ftest_Rp=1;
singleturn_test.ftest_Lleak=1;
singleturn_test.srf=0;
singleturn_test.srf_R=0;
singleturn_test.srf_C=0;

primary=singleturn_test;
primary.N=4;
secondary1=singleturn_test;
secondary1.N=1;
secondary2=singleturn_test;
secondary2.N=1;


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
% ftest=1e6;
% ftest=0.35e6;
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
%% primary magnetizing impedance
fprintf('primary magnetizing impedance\n')
baseline_filename='S2P_RECAL_P1PRIMARY_P2NONE_SECPOPEN_SECNOPEN.S2P';
port=1;
[f,S]=read_s2p(baseline_filename);
Z=Z0*s2z(permute(S,[3 2 1]));
Zs_mag=squeeze(Z(port,port,:));
% plot(f,real(Zs_mag),f,imag(Zs_mag));
%% get magnetizing inductance using lowest frequency data
Zs_mag_lowf=squeeze(Z(port,port,1));
lowf=f(1);
Lmag=imag(Zs_mag_lowf)./(2*pi*lowf);
DCR=real(Zs_mag_lowf);
primary.lowf_DCR=DCR;
primary.lowf_Lmag=Lmag;
fprintf('Low frequency: DCR = %.3f ohms, Lmag = %.3f uH\n',DCR,Lmag*1e6);
% print_series_equivalent(lowf,Zs_mag_lowf);
%% look for self resonance, peak magnitude impedance
[srf_Zs srf_idx]=max(abs(Zs_mag)); 
srf=f(srf_idx);
fprintf('SRF = %.3f MHz, peak Zmag=%.3f ohms\n',srf/1e6,srf_Zs);
Cp=1/((2*pi*srf)^2)/Lmag;
fprintf('Cp = %.2f pf\n',Cp*1e12);
primary.srf=srf;
primary.srf_R=srf_Zs;
primary.srf_C=Cp;
%% get impedance at f0
[df test_idx]=min(abs(f-ftest));
ftest=f(test_idx);
S=squeeze(S(test_idx,:,:));
Z=Z0*s2z(S);
Z=Z(port,port); 
print_parallel_equivalent(ftest,Z)
Y=1./Z;
primary.ftest_Rp=1/real(Y);
primary.ftest_Xp=-1/imag(Y);

fprintf('\n')
fprintf('*******************************************\n')
%% secondary magnetizing impedance
fprintf('secondary magnetizing impedance\n')
baseline_filename='S2P_P1NONE_P2SECN_SECPOPEN.S2P';
port=2;
[f,S]=read_s2p(baseline_filename);
Z=Z0*s2z(permute(S,[3 2 1]));
Zs_mag=squeeze(Z(port,port,:));
% plot(f,real(Zs_mag),f,imag(Zs_mag));
%% get magnetizing inductance using lowest frequency data
Zs_mag_lowf=squeeze(Z(port,port,1));
lowf=f(1);
Lmag=imag(Zs_mag_lowf)./(2*pi*lowf);
DCR=real(Zs_mag_lowf);
secondary1.lowf_DCR=DCR;
secondary1.lowf_Lmag=Lmag;
fprintf('Low frequency: DCR = %.3f ohms, Lmag = %.3f uH\n',DCR,Lmag*1e6);
% print_series_equivalent(lowf,Zs_mag_lowf);
%% look for self resonance, peak magnitude impedance
[srf_Zs srf_idx]=max(abs(Zs_mag)); 
srf=f(srf_idx);
fprintf('SRF = %.3f MHz, peak Zmag=%.3f ohms\n',srf/1e6,srf_Zs);
Cp=1/((2*pi*srf)^2)/Lmag;
fprintf('Cp = %.2f pf\n',Cp*1e12);
secondary1.srf=srf;
secondary1.srf_R=srf_Zs;
secondary1.srf_C=Cp;
%% get impedance at f0
[df test_idx]=min(abs(f-ftest));
ftest=f(test_idx);
S=squeeze(S(test_idx,:,:));
Z=Z0*s2z(S); 
Z=Z(port,port); 
print_parallel_equivalent(ftest,Z)
Y=1./Z;
secondary1.ftest_Rp=1/real(Y);
secondary1.ftest_Xp=-1/imag(Y);


fprintf('\n')
fprintf('*******************************************\n')
%% leakage inductance on 4T primary, one secondary turn shorted
fprintf('leakage inductance on 4T primary, one secondary turn shorted\n')
baseline_filename='S2P_RECAL_P1PRIMARY_P2NONE_SECPSHORT_SECNOPEN.S2P';
port=1;
[f,S]=read_s2p(baseline_filename);
[df test_idx]=min(abs(f-ftest));
ftest=f(test_idx);
S=squeeze(S(test_idx,:,:));
Z=Z0*s2z(S); 
Z=Z(port,port);
primary.ftest_Lleak=imag(Z)/(2*pi*ftest);

fprintf('\n')
fprintf('*******************************************\n')
%% leakage inductance on 1T secondary, other secondary shorted, primary open
fprintf('leakage inductance on 1T secondary, other secondary shorted, primary open\n')
baseline_filename='S2P_RECAL_P1SECP_P2NONE_SECNSHORT.S2P';
port=1;
[f,S]=read_s2p(baseline_filename);
[df test_idx]=min(abs(f-ftest));
ftest=f(test_idx);
S=squeeze(S(test_idx,:,:));
Z=Z0*s2z(S); 
Z=Z(port,port);
secondary1.ftest_Lleak=imag(Z)/(2*pi*ftest);

fprintf('\n')
fprintf('*******************************************\n')
%% secondary to secondary coupling
fprintf('secondary to secondary coupling\n')
baseline_filename='S2P_P1SECN_P2SECP_PRIOPEN.S2P';
[f,S]=read_s2p(baseline_filename);
% winding polarities are opposite, so make S21 and S12 negative
S(:,1,2)=-S(:,1,2); S(:,2,1)=-S(:,2,1);
[df test_idx]=min(abs(f-ftest));
ftest=f(test_idx);
S=squeeze(S(test_idx,:,:));
Z=Z0*s2z(S); 
N=1;
Z3=N*Z(1,2);
Z1=Z(1,1)-N*Z(1,2);
Z2=Z(2,2)-Z(1,2)/N;


return;
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
%% 4T primary to 1T secondary
fprintf('4T primary to 1T secondary\n')
baseline_filename='S2P_RECAL_P1PRIMARY_P2SECP_SECNOPEN.S2P';
[f,S]=read_s2p(baseline_filename);
% winding polarities are NOT opposite, so leave S21 and S12 alone
% S(:,1,2)=-S(:,1,2); S(:,2,1)=-S(:,2,1);
[df test_idx]=min(abs(f-ftest));
ftest=f(test_idx);
S=squeeze(S(test_idx,:,:));
Z=Z0*s2z(S); 
% ZL1=Z(1,1)-Z(2,1);
% ZL2=Z(2,2)-Z(2,1);
% fprintf('primary leakage ZL1 = Z11-Z21\n')
% print_series_equivalent(ftest,ZL1)
% fprintf('secondary leakage ZL2 = Z22-Z21\n')
% print_series_equivalent(ftest,ZL2)
% fprintf('magnetizing impedance = Z21\n')
% % print_series_equivalent(ftest,Z(2,1))
% print_parallel_equivalent(ftest,Z(2,1))
%{
convert to form

---Z1---o---o   o---Z2----
        |   |   |
        |   C   C
        Z3  C   C   N:1 ratio
        |   C   C
        |   |   |
%} 
N=4;
Z3=N*Z(1,2);
Z1=Z(1,1)-N*Z(1,2);
Z2=Z(2,2)-Z(1,2)/N;
return;
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