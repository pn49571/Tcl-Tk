#!/bin/env wish
 proc every {ms body} {eval $body; after $ms [info level 0]}
 proc drawhands w {
     $w delete hands
     set secSinceMidnight [expr { [clock seconds] - [clock scan 00:00:00] }]
     foreach divisor {60 3600 43200} length {45 40 30} width {1 3 7} {
         set angle [expr {$secSinceMidnight * 6.283185 / $divisor}]
         set x [expr {50 + $length * sin($angle)}]
         set y [expr {50 - $length * cos($angle)}]
         $w create line 50 50 $x $y -width $width -tags hands
     }
 }
 proc drawmarks w {
   set length1 46
   set length2 50
   foreach h {0 1 2 3 4 5 6 7 8 9 10 11} {
     set angle [expr {6.283185 / 12 * $h} ]
     set x1 [expr {50 + $length1 * sin($angle)}]
     set x2 [expr {50 + $length2 * sin($angle)}]
     set y1 [expr {50 - $length1 * cos($angle)}]
     set y2 [expr {50 - $length2 * cos($angle)}]
     $w create line $x1 $y1 $x2 $y2 -width 1
   }
 }
 proc toggle {w1 w2} {
     if [winfo ismapped $w2] {
         foreach {w2 w1} [list $w1 $w2] break ;# swap
     }
     pack forget $w1
     pack $w2
 }
 canvas .analog -width 100 -height 100 -bg white
 drawmarks .analog
 every 1000 {drawhands .analog}
 label .digital -textvar ::time -font {Courier 24}
 every 1000 {set ::time [clock format [clock sec] -format %H:%M:%S]}
 pack .analog
 bind . <1> {toggle .analog .digital}
