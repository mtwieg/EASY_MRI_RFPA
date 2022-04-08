irf520n.ssgain_dB=16.65;
irf520n.Pin_dBm=[   10,     13,     16,     19,     22,     22.2,   22.4,   22.6,   22.8,   23.0];
irf520n.Vrms=[  	15.33,  21.66,  30.89,  42.3,   55.60,  56.37,  57.18,  57.97,  58.74,  59.49];

irf630.ssgain_dB=16.21;
irf630.Pin_dBm= [   10,     13,     16,     19,     20,     21,     21.6,   21.7,   21.8,   21.9,   22.0];
irf630.Vrms= [  	30.8,  43.19,  60.92,  85.92,  94.68,  102.1,  106.0,  106.6,  107.1,  107.7,  108.28];

% correct Pin_dBm for the external gain (the other amp and 6dB attenuation)
irf520n.Pin_dBm=irf520n.Pin_dBm+irf630.ssgain_dB-6-0.1;
irf630.Pin_dBm=irf630.Pin_dBm+irf520n.ssgain_dB-0.1;

amp=irf520n;
amp.Pout_dBm=10*log10(amp.Vrms.^2/50*1000);
amp.gain_dB=amp.Pout_dBm-amp.Pin_dBm;
amp.Pout_dBm_ref=amp.Pin_dBm+amp.ssgain_dB;
amp.gain_P1dB_intercept=amp.gain_dB(2)-1;
amp.OP1dB=interp1(amp.gain_dB,amp.Pout_dBm,amp.gain_P1dB_intercept);
amp.IP1dB=interp1(amp.gain_dB,amp.Pin_dBm,amp.gain_P1dB_intercept);
irf520n=amp;

amp=irf630;
amp.Pout_dBm=10*log10(amp.Vrms.^2/50*1000);
amp.gain_dB=amp.Pout_dBm-amp.Pin_dBm;
amp.Pout_dBm_ref=amp.Pin_dBm+amp.ssgain_dB;
amp.gain_P1dB_intercept=amp.gain_dB(2)-1;
amp.OP1dB=interp1(amp.gain_dB,amp.Pout_dBm,amp.gain_P1dB_intercept);
amp.IP1dB=interp1(amp.gain_dB,amp.Pin_dBm,amp.gain_P1dB_intercept);
irf630=amp;

h1=figure(1); clf; 
ha1=plot(irf520n.Pin_dBm,irf520n.Pout_dBm,irf630.Pin_dBm,irf630.Pout_dBm);

xlabel('Pin (dBm)')
ylabel('Pout (dBm)')
legend('IRF520N x2','IRF630 x4','Location','SouthEast')
% xlim([0.1 20]);
% ylim([-10 20]);
grid on;

h2=figure(2); clf; 
ha2=plot(irf520n.Pin_dBm,irf520n.gain_dB,irf630.Pin_dBm,irf630.gain_dB);
xlims=h2.Children.XLim;
hold on;
refline1=plot(xlims,(irf520n.gain_dB(2)-1)*[1 1],'Color',ha2(1).Color,'LineStyle','--');
refline2=plot(xlims,(irf630.gain_dB(2)-1)*[1 1],'Color',ha2(2).Color,'LineStyle','--');
hold off;
xlabel('Pin (dBm)')
ylabel('Gain (dB)')
legend('IRF520N x2','IRF630 x4','Location','NorthEast')
% xlim([0.1 20]);
% ylim([-10 20]);

h3=figure(3); clf; 
ha3=plot(irf520n.Pout_dBm,irf520n.gain_dB,irf630.Pout_dBm,irf630.gain_dB,'LineWidth',2);
xlim([36 56]);
xlims=h3.Children.XLim;
hold on;
refline1=plot(xlims,(irf520n.gain_P1dB_intercept)*[1 1],'Color',ha3(1).Color,'LineStyle','--','LineWidth',2);
mark1=scatter(irf520n.OP1dB,irf520n.gain_P1dB_intercept,200,'x','MarkerEdgeColor','red','LineWidth',1.5);
refline2=plot(xlims,(irf630.gain_P1dB_intercept)*[1 1],'Color',ha3(2).Color,'LineStyle','--','LineWidth',2);
mark2=scatter(irf630.OP1dB,irf630.gain_P1dB_intercept,200,'x','MarkerEdgeColor','red','LineWidth',1.5);
hold off;

th1=text(irf520n.OP1dB-0.4,irf520n.gain_P1dB_intercept+0.07,sprintf('OP1dB=%.2f W',10^(irf520n.OP1dB/10-3)));
th1.HorizontalAlignment='right';
th2=text(irf630.OP1dB-0.4,irf630.gain_P1dB_intercept+0.07,sprintf('OP1dB=%.2f W',10^(irf630.OP1dB/10-3)));
th2.HorizontalAlignment='right';
xlabel('Pout (dBm)')
ylabel('Gain (dB)')
legend('IRF520N x2','IRF630 x4','Location','NorthEast')
% xlim([0.1 20]);
% ylim([-10 20]);
grid on;

return;
print(h3,'OP1dB_plot.png','-dpng','-r300');     