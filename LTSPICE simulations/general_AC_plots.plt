[AC Analysis]
{
   Npanes: 4
   {
      traces: 2 {8388614,0,"Zin(v2)"} {8388615,0,"Zout(v2)"}
      X: ('M',0,100000,0,2e+008)
      Y[0]: (' ',0,10,10,140)
      Y[1]: (' ',0,-40,10,80)
      Log: 1 0 0
      PltReal: 1
      PltImag: 1
      Representation: 2
   },
   {
      traces: 1 {5,0,"(1-abs(S11(v2))**2-abs(S22(v2))**2+abs(S11(v2)*S22(v2)-S12(v2)*S21(v2))**2)/(2*abs(S21(v2)*S12(v2)))"}
      X: ('M',0,100000,0,2e+008)
      Y[0]: (' ',0,1.41253754462275,1,6.30957344480193)
      Y[1]: ('m',1,-0.001,0.0002,0.001)
      Log: 1 2 0
      PltMag: 1
   },
   {
      traces: 1 {536870916,0,"S21(v2)"}
      X: ('M',0,100000,0,2e+008)
      Y[0]: (' ',0,0.354813389233575,3,7.94328234724282)
      Y[1]: (' ',0,-360,20,-100)
      Log: 1 2 0
      PltMag: 1
      PltPhi: 1 0
   },
   {
      traces: 2 {536870914,0,"S11(v2)"} {536870915,0,"S22(v2)"}
      X: ('M',0,100000,0,2e+008)
      Y[0]: (' ',0,0.0223872113856834,3,0.707945784384138)
      Y[1]: (' ',0,-360,60,240)
      Log: 1 2 0
      PltMag: 1
      PltPhi: 1 0
   }
}
