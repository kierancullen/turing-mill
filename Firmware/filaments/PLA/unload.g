;untested
G10 S215 ;set current tool temperature to 215C

M116 ;wait for temperature to be reached

M83 ;extruder in relative mode

G1 E-20 F300 ;retract 20mm slowly
G1 E-100 F3000 ;retract 100mm of filament quickly


M400 ;wait for moves to finish