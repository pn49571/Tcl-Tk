#! /bin/env tclsh

proc count {} {
    variable count
    if {[incr count] > 10} {
        puts "I'm done!"
        set ::forever 1
    } else {
        puts $count
        after 1000 count
    }
}

proc mood {} {
    variable count
    set mood [expr {$count % 2 ? "happy" : "sad"}]
    puts "I'm $mood!"
    after [expr {$count*500}] mood
}

after 0 count
after 0 mood
vwait forever
