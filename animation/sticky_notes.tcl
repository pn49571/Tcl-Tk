 namespace eval ::stickies {
     variable stickies

     array set stickies {
         Font             "Verdana 9"
         Count            0
         Animate          1
         Padding          {2 15 2 2}
         DefaultWidth     175
         DefaultHeight    150
         MenuFont         "Tahoma 8"
         Background       "#ffff80"
         StickyPopup      ".stickyPopup"
         StickyPrefix     ".sticky"
         BorderBackground "#ffdf00"
     }
 }

 proc ::stickies::init {} {
     variable stickies

     package require Tk 8.4
     set m [menu $stickies(StickyPopup) -tearoff 0 -font $stickies(MenuFont)]

     $m add command -label "Delete Note" \
         -command ::stickies::DeleteSticky -font "$stickies(MenuFont) bold"
     if {[string equal $::tcl_platform(platform) "windows"]} {
         if {[package vsatisfies $::tk_patchLevel 8.4.8]} {
             $m add command -label "Set Transparency" \
                 -command ::stickies::SetTransparency -font "$stickies(MenuFont)"
         }
         $m add separator
         $m add checkbutton -label "Always on Top" \
             -command ::stickies::AlwaysOnTop
     }
 }

 proc ::stickies::NewSticky {} {
     variable stickies

     set top $stickies(StickyPrefix)[incr stickies(Count)]

     set stickies($top,ontop) 0

     toplevel    $top -background $stickies(BorderBackground)
     wm withdraw $top
     update idletasks
     wm geometry $top 1x1
     wm override $top 1

     bind $top <3> [list ::stickies::PostPopup $top %X %Y]

     bindtags $top [list $top Toplevel $top StickyNote all]
     bind StickyNote <1>         [list ::stickies::GrabSticky   %W %X %Y]
     bind StickyNote <Motion>    [list ::stickies::StickyMotion %W %X %Y]
     bind StickyNote <B1-Motion> [list ::stickies::DragSticky   %W %X %Y]

     set padding $stickies(Padding)

     text $top.t -relief flat -background $stickies(Background) \
         -font $stickies(Font) -wrap word
     pack $top.t -expand 1 -fill both \
         -padx [list [lindex $padding 0] [lindex $padding 2]] \
         -pady [list [lindex $padding 1] [lindex $padding 3]]

     if {$stickies(Animate)} {
         ::stickies::AnimateSticky $top
     } else {
         wm geometry $top $stickies(DefaultWidth)x$stickies(DefaultHeight)
     }

     wm deiconify $top

     focus $top.t
 }

 proc ::stickies::AnimateSticky { window {w 0} {h 0} } {
     variable stickies

     wm deiconify $window

     incr w 10
     incr h 10
     if {$w > $stickies(DefaultWidth)}  { set w $stickies(DefaultWidth)  }
     if {$h > $stickies(DefaultHeight)} { set h $stickies(DefaultHeight) }

     wm geometry $window ${w}x${h}
     update idletasks
     if {$w != $stickies(DefaultWidth) || $h != $stickies(DefaultHeight)} {
         after 5 [list ::stickies::AnimateSticky $window $w $h]
     }

     return
 }

 proc ::stickies::PostPopup { window X Y } {
     variable stickies
     set stickies(ActiveSticky) $window
     $stickies(StickyPopup) post $X $Y
 }

 proc ::stickies::DeleteSticky { {window ""} } {
     variable stickies
     if {![string length $window]} { set window $stickies(ActiveSticky) }
     destroy $window
 }

 proc ::stickies::SetTransparency { {window ""} } {
     variable stickies
     if {![string length $window]} { set window $stickies(ActiveSticky) }

     set top $stickies(StickyPrefix)__set_transparency

     toplevel     $top
     wm title     $top "Set Transparency"
     wm withdraw  $top
     wm geometry  $top +[winfo x $window]+[winfo y $window]
     wm resizable $top 0 0

     set ::stickies::alpha [wm attributes $window -alpha]

     scale $top.scale -orient horizontal -from 0.0 -to 1.0 \
         -width 10 -length 150 -resolution .01 -showvalue 0 \
         -variable ::stickies::alpha \
         -command [list ::stickies::SetWindowAlpha $window]
     pack  $top.scale -side left -expand 1 -fill both

     button $top.ok -text "OK" -width 10 -command [list destroy $top]
     pack   $top.ok -side left

     $stickies(StickyPopup) unpost
     update idletasks

     wm deiconify $top
 }

 proc ::stickies::SetWindowAlpha { window value } {
     wm attributes $window -alpha $value
     update idletasks
 }

 proc ::stickies::AlwaysOnTop { {window ""} } {
     variable stickies
     if {![string length $window]} { set window $stickies(ActiveSticky) }

     set stickies($window,ontop) [expr $stickies($window,ontop) ? 0 : 1]
     puts "$window - $stickies($window,ontop)"
     wm attributes $window -topmost $stickies($window,ontop)
     puts "$window - $stickies($window,ontop) - [wm attributes $window]"

     $stickies(StickyPopup) unpost
     update idletasks
 }

 proc ::stickies::StickyMotion { window X Y } {
     variable stickies

     set minX [winfo x $window]
     set minY [winfo y $window]
     set maxX [expr {$minX + [winfo width  $window]}]
     set maxY [expr {$minY + [winfo height $window]}]

     set x1 [expr {$X - 8}]
     set x2 [expr {$X + 8}]
     set y1 [expr {$Y - 4}]
     set y2 [expr {$Y + 4}]

     set cursor ""
     set stickies(dir) ""

     if {$x1 < $minX} {
         set cursor sb_h_double_arrow
         set stickies(dir) w
     }
         
     if {$x2 > $maxX} {
         set cursor sb_h_double_arrow
         set stickies(dir) e
     }

     if {$y1 < $minY} {
          set cursor sb_v_double_arrow
          set stickies(dir) n
      }
         
     if {$y2 > $maxY} {
          set cursor sb_v_double_arrow
          set stickies(dir) s
     }

     if {$x2 > $maxX && $y2 > $maxY} {
         set cursor size_nw_se
         set stickies(dir) se
     }

     if {$x1 < $minX && $y1 < $minY} {
         set cursor size_nw_se
         set stickies(dir) nw
     }

     if {$x2 > $maxX && $y1 < $minY} {
         set cursor size_ne_sw
         set stickies(dir) ne
     }

     if {$x1 < $minX && $y2 > $maxY} {
         set cursor size_ne_sw
         set stickies(dir) sw
     }

     $window configure -cursor $cursor
     update idletasks
 }

 proc ::stickies::GrabSticky { window X Y } {
     variable stickies

     if {![string length $stickies(dir)]} {
         set stickies(Xoffset) [expr {[winfo x $window] - $X}]
         set stickies(Yoffset) [expr {[winfo y $window] - $Y}]
     } else {
         set stickies(Xoffset) $X
         set stickies(Yoffset) $Y
     }

     set stickies(x)      [winfo x $window]
     set stickies(y)      [winfo y $window]
     set stickies(width)  [winfo width  $window]
     set stickies(height) [winfo height $window]
 }

 proc ::stickies::DragSticky { window X Y } {
     variable stickies

     if {![string length $stickies(dir)]} {
         set x [expr {$X + $stickies(Xoffset)}]
         set y [expr {$Y + $stickies(Yoffset)}]
         wm geometry $window +${x}+${y}
         return
     }

     set adjX [expr {$X - $stickies(Xoffset)}]
     set adjY [expr {$Y - $stickies(Yoffset)}]

     set x      $stickies(x)
     set y      $stickies(y)
     set width  $stickies(width)
     set height $stickies(height)

     switch -- $stickies(dir) {
         "n" {
             set y $Y
             set height [expr {$stickies(height) - $adjY}]
         }

         "e" {
             set width  [expr {$stickies(width)  + $adjX}]
         }

         "s" {
             set height [expr {$stickies(height) + $adjY}]
         }

         "se" {
             set width  [expr {$stickies(width)  + $adjX}]
             set height [expr {$stickies(height) + $adjY}]
         }
     }

     if {$width <= 0 || $height <= 0} { return }

     wm geometry $window ${width}x${height}+${x}+${y}
     update idletasks
 }

 ## A little demo code.
 ::stickies::init

 button .b -text "New Sticky" -command ::stickies::NewSticky
 pack .b -expand 1 -fill both