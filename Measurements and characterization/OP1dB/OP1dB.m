
irf520n.f=[     0.1,    0.15,   0.2,    0.3,    0.5,    0.7,    1.0,    1.5,    2.0,    3.0,    4.0,    5.0,    5.1,    7.0,    10.0,   15.0,   20.0];
irf520n.Vrms=[  2.121,  3.447,  4.307,  5.307,  6.213,  6.678,  6.952,  7.115,  7.153,  7.099,  6.973,  6.813,  6.792,  6.407,  5.963,  4.875,  3.842];
irf630.f= [     0.1,    0.15,   0.2,    0.3,    0.5,    0.7,    1.0,    1.5,    2.0,    3.0,    3.4,    4.0,    5.0,    5.1,    7.0,    10.0,   15.0,   20.0];
irf630.Vrms= [  0.024,  0.1028, 0.2806, 0.6896, 1.261,  1.939,  3.120,  4.879,  5.931,  6.738,  6.775,  6.723,  6.486,  6.457,  5.819,  4.774,  3.294,  2.313];


Pin_dBm=13.0;

amp=irf520n;
amp.Pout_dBm=10*log10(amp.Vrms.^2/50*1000);
amp.gain_dB=amp.Pout_dBm-Pin_dBm;
irf520n=amp;

amp=irf630;
amp.Pout_dBm=10*log10(amp.Vrms.^2/50*1000);
amp.gain_dB=amp.Pout_dBm-Pin_dBm;
irf630=amp;

figure(1); clf; semilogx(irf520n.f,irf520n.gain_dB,irf630.f,irf630.gain_dB)
xlabel('Frequency (MHz)')
ylabel('S21 (dB)')
legend('IRF520N x2','IRF630 x4','Location','SouthEast')
xlim([0.1 20]);
ylim([-10 20]);
grid on;