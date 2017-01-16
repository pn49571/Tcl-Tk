#! /bin/env tclsh

package require Tk

proc animate2 {} {
    set ::cnt [ expr { ($::cnt+1) % $::total } ]
    .c raise BACKDROP
    .c raise step$::cnt
    after $::interval animate2
}

# draw a bunch of objects.  make sure that all have -tags $::t
proc makeFrame {tag params} {
    set ::t $tag ;# current tag
    foreach {x0 y0 up kx ky fx fy k2x k2y f2x f2y ex ey hx hy} $params {} ;# funky tcl trick for assignment
    set waist [list $x0 [expr $y0 + $up]]
    set neck [add $waist [list -7 -15]]  ; limb $waist $neck  blue
    set head [add $neck  [list -2 -4]]   ; limb $head [add $head [list -5 -5]]  pink

    set knee [add $waist [list $kx $ky]]  ; limb $waist $knee blue
    set foot [add $knee [list $fx $fy]]   ; limb $knee $foot blue
    set knee [add $waist [list $k2x $k2y]]  ; limb $waist $knee blue
    set foot [add $knee [list $f2x $f2y]]   ; limb $knee $foot blue

    set elbow [add $neck  [list $ex $ey]]  ; limb $neck $elbow  white
    set hand  [add $elbow [list $hx $hy]]  ; limb $elbow $hand  white
}

proc x {lst} {lindex $lst 0}
proc y {lst} {lindex $lst 1}
proc add {xy1 xy2} {
    return [list [expr [x $xy1]+[x $xy2]] [expr [y $xy1]+[y $xy2]]]
}

proc line {xy1 xy2 width color} {
    set id [.c create line [x $xy1] [y $xy1] [x $xy2] [y $xy2] \
     -width $width -capstyle round -fill $color -tags $::t ]
    .c addtag limb withtag $id
    if {$color == "black" } { .c addtag outline withtag $id  }
    if {$color == "black" } { .c lower $id 1 }
}
proc limb {xy xy2 color} {
    line $xy $xy2 9 black
    line $xy $xy2 6 $color
}

proc makeGiant {} {
    .c config -width 400 -height 400
    .c scale all 0 0 4 4
    .c itemconfig limb    -width 25
    .c itemconfig outline -width 35
    pack unpack .b
}

# parameters for each frame.  input to proc makeFrame
#   x0 y0 up   kx ky  fx fy  k2x k2y  f2x f2y    ex ey hx hy
set ::params {
    { 55 60  0    0 15   0 20    -8 13   13 15     7 10 -15  4}
    { 55 60 -1    2 14   9 10   -11  9    2 16     3 11 -15  1}
    { 55 60 -2    5 14  18  9   -14  5   -8 18    -2 12 -15 -2}
    { 55 60 -1   -1 13  15 12    -7 10   -4 19     3 11 -15  2}
    { 55 60  0   -8 13  13 15     0 15    0 20     7 10 -15  4}
    { 55 60 -1  -11  9   3 17     3 14   9 10     9  6  -4  9}
    { 55 60 -2  -14  5  -8 18     5 14  18  9    12  2  -7 13}
    { 55 60 -1   -7 10  -4 19    -3 14  15 12     9  6 -11  9}
}
set ::total [llength $::params]

set ::width  100
set ::height 100
set ::cnt 0
set ::interval 100

canvas .c -width $::width -height $::height

# create the animation frames
set idx 0
foreach p $::params {
    makeFrame step$idx $p
    incr idx
}


.c create rect  0  0 $::width $::height  -fill gray   -tag BACKDROP
.c scale 1 50 50 2 2 ;# make it bigger
.c create oval 10 10 30 30 -outline {}   -fill yellow -tag BACKDROP ;# sun
.c create line 20 20 30 30               -fill yellow -tag BACKDROP ;# sun
.c create line 20 20 20 35               -fill yellow -tag BACKDROP ;# sun
.c create line 20 20 35 20               -fill yellow -tag BACKDROP ;# sun
.c create line 20 20 10 35               -fill yellow -tag BACKDROP ;# sun
.c create line 20 20 35 10               -fill yellow -tag BACKDROP ;# sun

button .b -text "make giant" -command makeGiant

bind .c <Map> animate2

pack .c .b
