*2017 AIC
*Testbench file
******** DECLARE PARAMETER ********
.param V_SUPPLY=1.5V
.param V_CM =   0.75V

.param V_BIAS1= 0.9V * use your bias voltage here
.param V_BIAS2= 0.55V * use your bias voltage here
.param V_BIAS3= 0.8V * use your bias voltage here
******** SUPPLY AND BIAS ********
Vdd Vdd GND V_SUPPLY
Vcm Vcm GND V_CM

Vb1 Vb1 GND V_BIAS1
Vb2 Vb2 GND V_BIAS2
Vb3 Vb3 GND V_BIAS3

******** INCLUDE FILES ********
.include "opamp.spi"

******** MAIN CIRCUIT ********
.SUBCKT switch_n1 clk vin vout
Gsw vin vout VCR NPWL(1) clk 0 0 1000meg 1.5 0
.ENDS

XOTA VDD GND Vb1 Vb2 Vb3 Vcm Vin Vip Von Vop opamp

CLP Vop GND 2pF
CLN Von GND 2pF

Xs1 clk1 Vx net1 switch_n1
Xs2 clk2 Vcm net1 switch_n1
C1 net1 net2 4pF
Xs3 clk1 Vcm net2 switch_n1
Xs4 clk2 net2 Vip switch_n1
C2 Vip Von 2pF

Xs5 clk1 Vy net3 switch_n1
Xs6 clk2 Vcm net3 switch_n1
C3 net3 net4 4pF
Xs7 clk1 Vcm net4 switch_n1
Xs8 clk2 net4 Vin switch_n1
C4 Vin Vop 2pF
 
 
vc1 clk1    0 pulse (1.5 0   2.45u  0.5n 0.5n 4998n 5u)   
vc3 clk2    0 pulse (0 1.5 2.5u  0.5n 0.5n 4998n 5u)

vx  vx  0  pwl (0 0.75 2.05u 0.75 2.051u 0.8)
vy  vy  0  pwl (0 0.75 2.05u 0.75 2.051u 0.7)

******** OPERATION POINT ********
.op
.temp 25
.option post=1 $ display high-resolution plots of simulation results
.tran 0.01n 5u

.meas tran rise_time trig V(von) val=0.76 rise=1 targ V(von) val=0.84 rise=1
.meas tran fall_time trig V(vop) val=0.74 fall=1 targ V(vop) val=0.66 fall=1

.meas TRAN slew_rate_rise param=('0.08/rise_time/1e6')
.meas TRAN slew_rate_fall param=('0.08/fall_time/1e6')

******** INSTANCE LIB ********
.protect
.LIB 'cic018.l' TT
.unprotect
.end
