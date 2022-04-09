f0_ref=5.1; % target frequency, in MHZ. For putting reference line on figure

irf520n.f=[     0.1,    0.15,   0.2,    0.3,    0.5,    0.7,    1.0,    1.5,    2.0,    3.0,    4.0,    5.0,    5.1,    7.0,    10.0,   15.0,   20.0];
irf520n.Vrms=[  2.121,  3.447,  4.307,  5.307,  6.213,  6.678,  6.952,  7.115,  7.153,  7.099,  6.973,  6.813,  6.792,  6.407,  5.963,  4.875,  3.842];
irf630.f= [     0.1,    0.15,   0.2,    0.3,    0.5,    0.7,    1.0,    1.5,    2.0,    2.2,    3.0,    4.0,    5.0,    5.1,    7.0,    10.0,   15.0,   20.0];
irf630.Vrms= [  0.1177, 0.5014, 1.1069, 2.0871, 3.4907, 4.666,  5.8919, 6.6922, 6.9130, 6.930,  6.840,  6.570,  6.237,  6.203,  5.5285, 4.524,  3.191,  2.2732];


Pin_dBm=13.0;

amp=irf520n;
amp.Pout_dBm=10*log10(amp.Vrms.^2/50*1000);
amp.gain_dB=amp.Pout_dBm-Pin_dBm;
irf520n=amp;

amp=irf630;
amp.Pout_dBm=10*log10(amp.Vrms.^2/50*1000);
amp.gain_dB=amp.Pout_dBm-Pin_dBm;
irf630=amp;

h1=figure(1); clf; 
ha1=semilogx(irf520n.f,irf520n.gain_dB,irf630.f,irf630.gain_dB,'LineWidth',2)
xlabel('Frequency (MHz)')
ylabel('S21 (dB)')
lh=legend('IRF520N x2','IRF630 x4','Location','SouthEast','AutoUpdate','off');
xlim([0.1 20]);
ylim([-10 20]);

ylims=h1.Children(2).YLim;
hold on;
refline1=plot([f0_ref f0_ref],ylims,'Color',[0.5 0.5 0.5],'LineStyle','--','LineWidth',2);
% mark1=scatter(irf520n.OP1dB,irf520n.gain_P1dB_intercept,200,'x','MarkerEdgeColor','red','LineWidth',1.5);
% refline2=plot(xlims,(irf630.gain_P1dB_intercept)*[1 1],'Color',ha3(2).Color,'LineStyle','--','LineWidth',2);
% mark2=scatter(irf630.OP1dB,irf630.gain_P1dB_intercept,200,'x','MarkerEdgeColor','red','LineWidth',1.5);
hold off;
th1=text(f0_ref-0.4,2,sprintf('f=%.1f MHz',f0_ref));
th1.HorizontalAlignment='right';
grid on;

return;
print(h1,'S21_vs_f_plot.png','-dpng','-r300');     