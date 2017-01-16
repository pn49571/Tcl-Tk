###############################################################################################
##Normal operation
###############################################################################################
package require Thread
tsv::set myarray sum ''
tsv::set counter sumo 0
puts $sum
puts $sumo


proc t1 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data1
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "first counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "1thread: [expr {$end -$start}]"
    }
}

proc t2 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data2
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "second counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "2thread: [expr {$end -$start}]"
    }
}

proc t3 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data3
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "third counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "3thread: [expr {$end -$start}]"
    }
}

proc t4 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data4
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "fourth counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "4thread: [expr {$end -$start}]"
    }
}

proc t5 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data5
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "fifth counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "5thread: [expr {$end -$start}]"
    }
}

proc t6 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data6
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "sixth counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "6thread: [expr {$end -$start}]"
    }
}

proc t7 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data7
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "seventh counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "7thread: [expr {$end -$start}]"
    }
}

proc t8 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data8
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "eighth counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "8thread: [expr {$end -$start}]"
    }
}

proc t9 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data9
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "nine counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "9thread: [expr {$end -$start}]"
    }
}

proc t10 {} {
    thread::create {
        # set start [clock microseconds]
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data10
        proc regu {arg} {
            set a [regexp {(sai[a-z]+)} "$arg"]
            return $a
        }
        db1 function regexp regu
        set res "[db1 eval {SELECT *  FROM contracts WHERE regexp(first_name)}]"
        tsv::append myarray sum $res
        tsv::incr counter sumo 1
        # puts "tenth counter: [tsv::get counter sumo]"
        # set end [clock microseconds]
        # puts "10thread: [expr {$end -$start}]"
        
    }
}

proc t11 {} {
    thread::create {
        set start [clock microseconds]
        for {set i 0} {$i < 999999} {incr i} {
            set a [tsv::get counter sumo]
            if {$a > 9} {
                break
            }
        }
        puts "final counter: [tsv::get counter sumo]"
        puts "final value: [tsv::get myarray sum]"
        set end [clock microseconds]
        puts "Time to run:  [expr {$end -$start}]"
        
    }
}


t1
t2
t3
t4
t5
t6
t7
t8
t9
t10
t11
