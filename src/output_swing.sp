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
XOTA VDD GND Vb1 Vb2 Vb3 Vcm Vin Vip Von Vop opamp

CLP Vop GND 2pF
CLN Von GND 2pF

 

 Vip  vip   gnd  SIN "V_CM"  "0.1"  100k
Vin  vin   gnd  SIN "V_CM"  "-0.1" 100k

******** OPERATION POINT ********
.op
.temp 25
.option post=1 $ display high-resolution plots of simulation results
.tran 0.01n 50u

******** INSTANCE LIB ********
.protect
.LIB 'cic018.l' TT
.unprotect
.end
