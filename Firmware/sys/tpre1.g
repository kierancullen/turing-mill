; tpre1.g
; called before tool 1 is selected

;Unlock Coupler
M98 P"/macros/Coupler - Unlock"

;Move to location
G1 X78.0 Y150 F50000

;Move in
G1 X78.0 Y210 F50000

;Collect
G1 X78.0 Y221.3 F1500 ;incremeted closer by 0.3

;Close Coupler
M98 P"/macros/Coupler - Lock"

;WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!
;if you are using non-standard length hotends ensure the bed is lowered enough BEFORE undocking the tool!
G91
G1 Z25 F1000
G90

;Move Out
G1 X78.0 Y150 F4000
