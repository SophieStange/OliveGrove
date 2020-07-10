; Olivefruitflie Population in Ecosystem of Olive Grove
; @author Paulin Moeller, Sophie Stange
; @license CC-by-SA 4.0
; @copyright Paulin Moeller, Sophie Stange


;;-----------------------------------------------------------------
; AGENDA
;;-----------------------------------------------------------------

; 1) GLOBALS

; 2) DECLARATION turtles

; 3) SETUP
;    3.1) General Setup
;    3.2) Setup Calender
;    3.3) Setup Turtles
;         3.3.1) Setup Trees
;         3.3.2) Setup Flies
;    3.4) Setup Patches

; 4) Standard Settings CULTIVATION METHODS

; 5) SETUP Pest Control Methods
;    5.1) Setup Traps
;    5.2) Setup Cover Sprays
;    5.3) Setup Predators
;    5.4) Setup SIT

; 6) GO Button
;    6.1) GO Calender
;         6.1.1) Weather Generation Function
;         6.1.2) Calender Advance
;    6.2) GO Flies

; 7) Olive Variety

; 8) Harvest Time
;
;
;
;


;;-------------------------------------------------------------------------------
; 1) GLOBALS
;;-------------------------------------------------------------------------------

globals [

  ;calender
    month
    day
    doy
    days-in-months
    temperature

]


;;-------------------------------------------------------------------------------
; 2) DECLARATION turtles
;;-------------------------------------------------------------------------------

breed [ trees tree ]
breed [ flies fly ]                         ;??? Male and females???
breed [ predators predator ]
breed [ traps trap ]
breed [ sterile-flies steril-fly ]

turtles-own [energy] ; all turtles having enrgy level

;;-------------------------------------------------------------------------------
; 3) SETUP
;;-------------------------------------------------------------------------------


;;-------------------------------------------------------------------------------
;    3.1) General Setup
;;-------------------------------------------------------------------------------


to setup
  clear-all
  setup-trees
  setup-flies
  setup-patches
  setup-calender
  ;setup-cultivation-method
  reset-ticks

end


;;-------------------------------------------------------------------------------
;    3.2) Setup Calender
;;-------------------------------------------------------------------------------

to setup-calender
  set month 1
  set day 1
  set doy 1
  set days-in-months (list 31 28 31 30 31 30 31 31 30 31 30 31)
  reset-ticks

end


;;-------------------------------------------------------------------------------
;    3.3) Setup Turtles
;;-------------------------------------------------------------------------------


;;-------------------------------------------------------------------------------
;         3.3.1) Setup Trees
;;-------------------------------------------------------------------------------

to setup-trees
  span-by-density

end


; create tree grid

to span-by-density
  let varianz ( 100 - tree-density ) / 5
  let x-int  ( world-width * tree-density / 100 / 10 + varianz )            ;formula for distance between trees at x-axis, horizontal. /100 -> %. 10 is tree size.
  let y-int  ( world-height * tree-density / 100 / 10 + varianz )           ;formula for distance between trees at y-axis, vertical

  let h-vals ( range ( min-pxcor + 5 ) ( max-pxcor + 5 ) x-int )            ;list with possible positions with setted distance x-int. Varies due to tree-density
  let v-vals ( range ( min-pycor + 5 ) ( max-pycor + 5 ) y-int )            ;list with possible positions with setted distance y-int. Varies due to tree-density

  let possible-coords []                                                    ;creates list with all coordinates = combination of elements of h-vals and v-vals (Eine große Liste mit ganz vielen kleinen Listen darin)

  foreach v-vals [                                                           ;foreach runs following formula for each element of the list v-vals
    v ->                                                                     ; v = variable for element of list
    set possible-coords (                                                    ; formula describes all possible combinations of elements of list v-vals and h-vals
      sentence possible-coords map [                                         ; => possible coordinates for trees (in small sublists)
        i ->                                                                 ; Explanation for command map:  https://ccl.northwestern.edu/netlogo/docs/dictionary.html#map
        (list i v)
      ] h-vals
    )
  ]


  foreach possible-coords [                                                     ; foreach runs commands for each element (= couple of coordinates) of list possible-coords
    coords ->                                                                   ; element = couple of coords = mini-list of two elements = variable "coords"
    let pos-x item 0 coords
    let pos-y item 1 coords
    if pos-x > 99 [set pos-x 99]
    if pos-y > 99 [set pos-y 99]
    create-trees 1 [                                                            ; creates described tree for element coords
      set shape "circle"
      set color green
      set energy 100
      set size 10
      setxy pos-x pos-y                                                         ; sets x = first item of mini-list "coords" = 0
    ]                                                                           ; and  y = second item of mini-list "coords" = 1
  ]                                                                             ; bc. foreach this repeats for each couple of possible coordinates

end


;;-------------------------------------------------------------------------------
;         3.3.2) Setup Flies
;;-------------------------------------------------------------------------------

to setup-flies

create-fem-flies                                                              ; create a group of female and anoter of male flies.
create-mal-flies

end

to create-fem-flies

  create-flies 200 [
  set shape "bug"
  set color black
  set energy 50
  set size 0.5
  setxy random-xcor random-ycor
]

end

to create-mal-flies

  create-flies 200 [
  set shape "bug"
  set color blue
  set energy 50
  set size 0.5
  setxy random-xcor random-ycor
]

end



;;-------------------------------------------------------------------------------
;    3.4) Setup Patches
;;-------------------------------------------------------------------------------

to setup-patches
  ask patches [set pcolor 28 ]

end



;;-------------------------------------------------------------------------------
; 4) Standard Settings CULTIVATION METHODS
;;-------------------------------------------------------------------------------

to Confirm-selection
  setup-cultivation-method

end

to setup-cultivation-method


  if Cultivation-method = "Traditional-extensive-production"   [ set Number-of-traps 50
                                                                 set Cover-sprays 30
                                                                 set Predator-method  30
                                                                 set SIT 30
                                                                 set Tree-density 50]

  if Cultivation-method = "Organic-production"                 [ set Number-of-traps 50
                                                                 set Cover-sprays 30
                                                                 set Predator-method  30
                                                                 set SIT 30
                                                                 set Tree-density 50]

  if Cultivation-method = "Traditional-intensified-production" [ set Number-of-traps 50
                                                                 set Cover-sprays 30
                                                                 set Predator-method  30
                                                                 set SIT 30
                                                                 set Tree-density 50]

  if Cultivation-method = "Industrial-production"              [ set Number-of-traps 50
                                                                 set Cover-sprays 30
                                                                 set Predator-method  30
                                                                 set SIT 30
                                                                 set Tree-density 50]

end




;;-------------------------------------------------------------------------------
; 5) Setup Pest Control Methods
;;-------------------------------------------------------------------------------


;;-------------------------------------------------------------------------------
;    5.1) Setup Traps
;;-------------------------------------------------------------------------------

to setup-traps
  create-traps Number-of-traps [
  set shape "box"
  set color 8
  ]

end

;;-------------------------------------------------------------------------------
;    5.2) Setup Cover Sprays
;;-------------------------------------------------------------------------------




;;-------------------------------------------------------------------------------
;    5.3) Setup Predators
;;-------------------------------------------------------------------------------




;;-------------------------------------------------------------------------------
;    5.4) Setup SIT
;;-------------------------------------------------------------------------------



;
;TREE DENSYTY ???????????
;




;;-------------------------------------------------------------------------------
; 6) GO Button
;;-------------------------------------------------------------------------------


to go
  go-time
  go-flies
  tick
  if doy = 365 [
  stop
  ]

end

;;-------------------------------------------------------------------------------
;    6.1) GO Calender
;;-------------------------------------------------------------------------------

to go-time
  update-temperature
  advance-calender

end

;;-------------------------------------------------------------------------------
;         6.1.1) Weather Generation Function
;;-------------------------------------------------------------------------------

to update-temperature



  let daily-temperature-sigma 3.0
  let seasonal-temperature-range 18.0

  ;; define a base temperature seasonal signal with 120 day shift
  ;; (i.e. maximum  on 1 August, minimum 1 Feb)

  let base-temperature 19 + sin ( ( doy - 120 + random 19 )
    * 360.0 / (365 ) ) * seasonal-temperature-range / 2.0

  set temperature random-normal base-temperature daily-temperature-sigma


end


;;-------------------------------------------------------------------------------
;         6.1.2) Calender Advance
;;-------------------------------------------------------------------------------

to advance-calender

  set day day + 1
  set doy doy + 1

   ; implement month change
   ; if day > days-in-months of this month
   ; if doy > sum(prior and current full months)

   ; define a local variable (not known outside of this procedure)
   ; scope is the
  let local-doy sum sublist days-in-months 0 month

  if local-doy > 31 [
    set local-doy local-doy
  ]

  if doy > local-doy [
    set month month + 1
    set day 1
  ]

end


;;-------------------------------------------------------------------------------
;    6.2) GO Flies
;;-------------------------------------------------------------------------------


  to go-flies                                                                     ; 1) Random movement
  move-flies                                                                      ; 2) Fertile period: Searching males (blue)/ females (pink) to match up;
                                                                                  ; 3) Pregnant females searching trees, leaving eggs -> reducing trees' value
                                                                                  ; 4) When trees' value = 0, no more space for eggs
end                                                                               ; 5) After leaving eggs, female flies continue random movement, not fertile anymore??? (black again)

; random movement from january to may????

to move-flies
                                                                                  ; 1) Until may moving between 0 and 3 steps, by poss. of 50 %,
  ask flies[                                                                      ;    turning right in angle between 0 and 45°, by poss. of 50 %
  if month < 5 [
  if random 100 < 50 [
    forward random 3
    right random 45
    ]
    ]
  ]

end



;;-------------------------------------------------------------------------------
 ; Olive-vairety
;;-------------------------------------------------------------------------------




;;-------------------------------------------------------------------------------
 ; Harvest time
;;-------------------------------------------------------------------------------





@#$#@#$#@
GRAPHICS-WINDOW
366
196
779
610
-1
-1
4.05
1
5
1
1
1
0
0
0
1
0
99
0
99
0
0
1
ticks
30.0

BUTTON
22
562
92
595
NIL
Setup\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
112
563
181
596
NIL
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
19
167
236
212
Cultivation-method
Cultivation-method
"Traditional-extensive-production" "Organic-production" "Traditional-intensified-production" "Industrial-production"
2

SLIDER
16
332
188
365
Number-of-traps
Number-of-traps
0
100
50.0
1
1
NIL
HORIZONTAL

SLIDER
16
373
188
406
Cover-sprays
Cover-sprays
0
100
30.0
1
1
NIL
HORIZONTAL

SLIDER
18
417
190
450
Predator-method
Predator-method
0
100
30.0
1
1
NIL
HORIZONTAL

SLIDER
18
460
190
493
SIT
SIT
0
100
30.0
1
1
NIL
HORIZONTAL

PLOT
796
426
1092
608
Healthy olives
Time
Healty olives in kg
0.0
365.0
0.0
10000.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot sum [energy] of trees"

SLIDER
17
263
189
296
Tree-density
Tree-density
0
100
17.0
1
1
NIL
HORIZONTAL

MONITOR
1098
235
1155
280
N° Flys
Count flies
17
1
11

MONITOR
1104
429
1219
474
Healthy olives in kg
sum [energy] of trees
17
1
11

PLOT
439
10
1191
188
Climate
Time
Temperature / Humidity
0.0
365.0
0.0
40.0
true
true
"" ""
PENS
"Temperature" 1.0 0 -2139308 true "" "plot temperature"
"Air humidity" 1.0 0 -14070903 true "" "plot air-humidity"

MONITOR
1103
485
1209
530
NIL
Monetary value
17
1
11

MONITOR
367
141
424
186
Day
Day
17
1
11

CHOOSER
25
53
165
98
Olive-variety
Olive-variety
"a" "b" "c"
0

CHOOSER
196
54
334
99
Harvest-time
Harvest-time
"September" "October" "November"
0

PLOT
797
234
1090
407
Fly population
time
Individuals
0.0
365.0
0.0
1000.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count flies"

MONITOR
1098
285
1204
330
NIL
N° Generations
17
1
11

BUTTON
199
563
277
596
Go-once
Go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
367
74
424
119
Month
Month
17
1
11

BUTTON
19
217
138
250
NIL
Confirm-selection
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
366
10
423
55
doy
doy
17
1
11

TEXTBOX
25
24
315
65
1) Select olive variety and time of harvest.
13
0.0
1

TEXTBOX
23
125
320
181
2) Select cultivation-method and confirm selection with button.
13
0.0
1

TEXTBOX
201
263
341
504
3) Vary the standard settings of tree-density or pestcontrol methods as you wish to see certain effects of singular changes.
13
0.0
1

TEXTBOX
18
311
168
329
Pest control methods:
13
82.0
1

TEXTBOX
19
519
318
565
4) Click Setup to prepare for a new simulation and Go / Go-once to start it.
13
0.0
1

TEXTBOX
795
206
1190
240
Visualisation of development of fly and olive population:
14
34.0
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

- holistic understanding of the olive-fruit-fly-challenge in the Mediterranean (or more specifically in Greece) and how it can (or cannot) be tackled successfully

The model offers the possibility to try out effects of single variables in four different production methods for oleicultures. It focusses especially on the control of damage at the harvest due to the olive fly as a pest in the olive production.
Therefore it reproduces the application of four different pest control methods in an adjustable range of intensity. Hereby the effect on fly population and olive harvest becomes observable during an annual season, wich corresponds with a harvest cicle in olive cultivation.


## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)
???
-
-
-
-


## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

- Setup
	-trees in grid
	-flies randomly distrubuted
-Go
	-starts simulation of annual cycle on olivegrove:
		-olives grow depending on climatic circumstances of year(Energy value)
		-flies start to seek olives to place eggs
		-Larvae eclose and eat olives' pulp

		--> reducing olives' energy value

-Limiting factors to fly population:

	-climate (climate diagram)

	-olive variety (chooser
		-variety decides over harvest time, size ... and... of olive. 
		-flies prefer...

	-harvest time (chooser)
		- flies place eggs in ...(month)... 
		- and prefer darker and therefor warmer olives for their larvae
		- depending on harvest time time overlap to place eggs or not

	-cultivation method (chooser + button to confirm selection)
			-depending on cultivation method standardized setting for 					following sliders:

				-tree-density: distance between trees influencing olives' 				energy value and flies' distribution 

				- pest-control-methods:

					-numer-of-traps: ...

					-cover-sprays: ...

					-predator-method: ...

					-SIT: sterile intect technique is about the 							genetic modification of male fly individuals to 						be sterile. The artificial entry of those 							individuals reduces the fly population over time.

		
			- 1) traditional extensive production: low tree density, big 					trees, many predator supporting activities/conditions, no SIT, no 			cover sprays, no-a few traditional traps, (no-irrigation), (small 			aromatic olive variety), (early harvest --> olives color: lighter 			green)

			- 2) organic production: normal tree density, normal tree size, 				some predator supporting activities/conditions, no SIT, specific 				cover sprays for organic production, specific allowed trap, (some 			irrigation), (normal-size quiet aromatic variety), (normal 					harvest time --> perfect compromise of quality and quantity, 					darker green/little black)

			- 3) intensified traditional production: normal tree density, 					normal tree size, no-few predator supporting 							activities/conditions, maybe SIT, normal use of standard cover 					sprays, standard mass-trapping, (some irrigation) (normal-size 					quiet aromatic variety) (normal harvest time --> darker 					green/little black)

			- 4) industrial production: high tree density + small tree size 				--> hedge, no-few predator supporting activities/conditions, 					maybe SIT, intensive use of standard cover sprays, intensive 					mass-trapping, (much irrigation), (big not so aromatic olive 					variety) (normal-late harvest --> optimized quantity but still an 			adequate quality, even darker green/black)

		- in each standardized setting individual factors of pest control can be 			changed using the sliders to observe their specific effect on 					flie population and olive harvest. Both are observable in two seperate 				plots. Extra monitors show the number of flies in the population, the 				number of generation, the effective mass of healthy olives in kg and in 			the monetary equivalent.


## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
