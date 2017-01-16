##+##########################################################################
#
# stars.tcl -- Does a starfield animation
# by Keith Vetter  Oct 5, 2003
#
package require Tk
 
array set S {w 500 h 500 afterID "" delay 20 lbl,0 "Go" lbl,1 "Stop"}
array set G {go 1 rot 0 drot 1}
 
##+##########################################################################
# 
# NewStar -- Creates new stars of a given type
# 
proc NewStar {cnt type} {
    global S STARS
 
    if {! [info exists STARS(cnt)]} {set STARS(cnt) -1}
    while {[incr cnt -1] >= 0} {
        set x [expr {rand() * $S(w) - $S(w2)}]  ;# Select x,y,z for new star
        set y [expr {rand() * $S(h) - $S(h2)}]
        if {$x == 0 && $y == 0} {set x 10}
        set z [expr {int(rand() * 100)}]
 
        set idx [incr STARS(cnt)]               ;# Save into our global array
        set STARS($idx) [list $x $y $z $type]
        set n [.c create rect -999 -999 -999 -999]
        set STARS(tag,$idx) $n
    }
}
##+##########################################################################
# 
# StarDraw -- draws one star
# 
proc StarDraw {idx} {
    global STARS S G
 
    foreach {x y z type} $STARS($idx) break
    incr z -2                                   ;# It's getting closer
    if {$z < -63} {set z 100}
 
    set xx [expr {($x*64) / (64+$z)}]           ;# Divide by z to get location
    set yy [expr {($y*64) / (64+$z)}]
    set X [expr {$xx * $G(rot,cos) - $yy*$G(rot,sin)}] ;# Rotate if needed
    set Y [expr {$xx * $G(rot,sin) + $yy*$G(rot,cos)}]
    if {abs($X) > $S(w2) || abs($Y) > $S(h2)} {set z 100} ;# Offscreen?
    lset STARS($idx) 2 $z
    
    set color [expr {$z > 50 ? "gray" : $z > 35 ? "lightgray" : "white"}]
    if {$type == 0} {
        set d [expr {(100 - $z) / 50}]
        if {$d == 0} {set d 1}
        .c coords $STARS(tag,$idx) [MakeBox $X $Y $d]
        .c itemconfig $STARS(tag,$idx) -fill $color
    } else {                                    ;# Cross hair type star
        .c delete star_$idx
 
        set d [expr {(100 - $z) / 20}]
        foreach {x0 y0 x1 y1} [MakeBox $X $Y $d] break
        .c create line $x0 $Y $x1 $Y -tag star_$idx -fill $color
        .c create line $X $y0 $X $y1 -tag star_$idx -fill $color
        if {$z < 50} {
            set d [expr {$d / 2}]
            foreach {x0 y0 x1 y1} [MakeBox $X $Y $d] break
            .c create line $x0 $y0 $x1 $y1 -tag star_$idx -fill $color
            .c create line $x1 $y0 $x0 $y1 -tag star_$idx -fill $color
        }
    }
}
##+##########################################################################
# 
# StarAnimate -- does one round of updating all the stars then schedules
# itself to be called again after a short delay.
# 
proc StarAnimate {} {
    global G S STARS
 
    set now [clock click -milliseconds]
    after cancel $S(afterID)
    if {! $G(go)} return
 
    set G(rot) [expr {$G(rot) + $G(drot)*3.14159/180}]
    set G(rot,cos) [expr {cos($G(rot))}]
    set G(rot,sin) [expr {sin($G(rot))}]
 
    for {set j 0} {$j <= $STARS(cnt)} {incr j} {
        StarDraw $j
    }
    if {! $G(go)} return
 
    # Keep delay between rounds constant if possible
    set t [expr {[clock click -milliseconds] - $now}]
    set delay [expr {$S(delay) - $t}]
    if {$delay <= 0} {set delay 1}
    set S(afterID) [after $delay StarAnimate]
}
proc Stop {} {
    global G S
 
    set G(go) [expr {! $G(go)}]
    .stop config -text $S(lbl,$G(go))
    if {$G(go)} StarAnimate
}
proc MakeBox {x y d} {
    return [list [expr {$x-$d}] [expr {$y-$d}] [expr {$x+$d}] [expr {$y+$d}]]
}
proc Scaler {n} {.rot config -label "Rotation: $n"} ;# Relabels scale widget
proc ToggleCtrl {} {                            ;# Toggles control panel
    if {[winfo ismapped .bottom]} {
        pack forget .bottom
    } else {
        pack .bottom -side bottom -fill x -before .c
    }
}
proc ReCenter {W h w} {                   ;# Called by configure event
    global S
    foreach S(w) $w S(h) $h break
    foreach S(w2) [expr {$w /2}] S(h2) [expr {$h /2}] break
    $W config -scrollregion [list -$S(w2) -$S(h2) $S(w2) $S(h2)]
}
proc DoDisplay {} {
    ########Font-inserted############################
    set S(txt) "Health IT Lab@UMBC"
    set S(font) {Times 64 bold}
    label .l -text " $S(txt) " -font $S(font) -fg red -bg black -bd 0
    label .msg -textvariable S(msg) -bd 2 -relief ridge
    pack  .l .msg -side top -fill x
    canvas .c -width $::S(w) -height $::S(h) -bg black -highlightthickness 0
    frame .bottom
    button .stop -text "Stop" -command Stop -width 5
    .stop configure  -font "[font actual [.stop cget -font]] -weight bold"
    scale .rot -from -5 -to 5 -orient h -variable G(drot) \
        -showvalue 0 -command Scaler -relief ridge
    pack .c -side top -expand 1 -fill both
    pack .stop .rot -in .bottom -side right -expand 1
    image create photo ::img::blank -width 1 -height 1
    button .about -image ::img::blank -highlightthickness 0 \
        -command {tk_messageBox -message "Stars\nby Keith Vetter, October 2003"}
    place .about -in .bottom -relx 1 -rely 0 -anchor ne
    bind .c <Configure> {
        ReCenter %W %h %w
        NewStar 10 1
	NewStar 90 0
	StarAnimate
	bind .c <Configure> {
             ReCenter %W %h %w
         }
     }
    #     bind all <Double-Button-1> ToggleCtrl
    bind all <ButtonPress-1> ToggleCtrl
#    bind all <Enter> ToggleCtrl
}
 
DoDisplay
