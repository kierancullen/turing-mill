;untested
G10 S215 ;set current tool temperature to 215C

M116 ;wait for temperature to be reached

M83 ;extruder in relative mode

G1 E100 F600 ;feed 100mm slowly

M400 ;wait for moves to finish