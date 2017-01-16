 ##+##########################################################################
 #
 # Wavy Text
 # by Keith Vetter, December, 2005
 #
 package require Tk
 package require Img
 
 set S(txt) "Health IT Lab@UMBC!"
 set S(font) {Times 64 bold}

 set S(step)  10                                ;# Step size in sin function
 set S(scale)  5                                ;# How far to shift image
 set S(angle)  0                                ;# Starting angle
 set S(delay) 10                                ;# How often to draw image
 set S(kill)   0                                ;# Stops animation
 set S(rad) [expr {acos(-1) / 180}]
 
 proc MovePix {angle} {
    global S
 
    set iname ::img::dst($angle)
    if {[lsearch [image names] $iname] > -1} return ;# Is it already done?
 
    image create photo $iname -width $S(w) -height $S(h)
 
    for {set col 0} {$col < $S(w)} {incr col} {
        set dcol [::img::src data -from $col 0 [expr {$col+1}] $S(h)]
 
        set dy [expr {sin($angle * $S(rad)) + 1}] ;# 0-2 range
        set dy [expr {int($dy * $S(scale) + .5)}] ;# 0-scale range
        set dcol [RotateList $dcol $dy]
        $iname put $dcol -to $col 0
 
        set angle [expr {$angle + $S(step)}]
    }
 }
 proc RotateList {l n} {
    set n [expr {$n % [llength $l]}]
    return [concat [lrange $l $n end] [lrange $l 0 [expr {$n-1}]]]
 }
 proc Animate {{start 0}} {
    if {$start} {set ::S(kill) 0}
    if {$::S(kill)} return
    .l config -image ::img::dst($::S(angle))
    set ::S(angle) [expr {($::S(angle) + $::S(step)) % 360}]
    after $::S(delay) Animate
 }
 
 wm title . "Wavy Text"
 bind all <1> {set ::S(kill) 1}
 label .l -text " $S(txt) " -font $S(font) -fg red -bg black -bd 0
 label .msg -textvariable S(msg) -bd 2 -relief ridge
 pack  .l .msg -side top -fill x
 update
 image create photo ::img::src -data .l
 set S(w) [image width ::img::src]
 set S(h) [image height ::img::src]
 image create photo ::img::dst -width $S(w) -height $S(h)
 
 for {set i 0} {abs($i) <= 360} {incr i $S(step)} {
    set ia [expr {abs($i)}]
    set S(msg) "building images: $ia/360"
    update
    MovePix $ia
 }
 set S(msg) ""
 set S(step) [expr {-$S(step)}]
 
 Animate 1
 return
