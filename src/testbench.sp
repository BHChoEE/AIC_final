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


Vdd_p Vdd_p GND dc 1.5 ac 1
Vinp Vinp GND dc 0.75
Vipp Vipp GND dc 0.75
******** INCLUDE FILES ********
.include "opamp.spi"

******** MAIN CIRCUIT ********

XOTA VDD GND Vb1 Vb2 Vb3 Vcm Vin Vip Von Vop opamp
XOTA2 Vdd_p GND Vb1 Vb2 Vb3 Vcm Vinp Vipp Vonp Vopp opamp
CLP Vop GND 2pF
CLN Von GND 2pF
CLPp Vopp GND 2pF
CLNp Vonp GND 2pF
******** INPUT SIGNALS ********
XSE2DIFF Vcm GND Vi Vip Vin SE2DIFF
Vtest Vi GND DC 0 AC 1
******** BEHAVIOR SE-TO-DIFF CONVERTER ********
.subckt SE2DIFF Vcm Vss Vi Vop Von
E1 Vop Vcm Vi Vss 0.5
E2 Vcm Von Vi Vss 0.5
.ends SE2DIFF
******** OPERATION POINT ********
.op
.temp 25
.ac dec 10 1mHZ 1000MEG
.option post=1 $ display high-resolution plots of simulation results

.print ac VDB(Vop, Von) VP(Vop, Von)
.print ac VDB(Vop, Von)
.print Ad=par('VDB(Vop,Von)')
.print Avdd=par('VDB(Vopp, Vonp)')
.print PSRR=par('Ad-Avdd') $ PSRR measurement
.meas ac gain max VDB(Vop, Von) $ gain measurement
.meas ac phase_margin find=par('VP(Vop, Von)+180') when VDB(Vop, Von)=0 $ phase margin measurement
.meas ac unit_gain_freq when VDB(Vop, Von)=0 $ unit gain frequency measurement
.meas ac power avg par('-1*p(vdd)') $ power measurement


******** INSTANCE LIB ********
.protect
.LIB 'cic018.l' TT
.unprotect
.end
