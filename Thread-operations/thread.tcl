###################################################################################################
#Multi-threading
#
###################################################################################################
package require Thread
set start [clock microseconds]
tsv::set myarray sum 0

proc t1 {} {
    thread::create {
        # set start [clock microseconds]
        # puts "Entering first thread"
        package require sqlite3
        sqlite3 db1 syn_data
        set res [db1 eval {SELECT SUM(id) FROM contracts WHERE id BETWEEN 1 AND 521245 }]
        tsv::incr myarray sum $res
        # set end [clock microseconds]
        # puts "first: [expr {$end -$start}]"
        # puts "Sum: [tsv::get myarray sum]"
        # puts "Above is the result of first thread"

    }
}

# proc t2 {} {   
#     thread::create {
#         # set start [clock microseconds]
#         # puts "Entering first thread"
#         package require sqlite3
#         sqlite3 db2 syn_data
#         set res [db2 eval {SELECT SUM(id) FROM contracts WHERE id BETWEEN 260623 AND 521244 }]
#         tsv::incr myarray sum $res
#         # set end [clock microseconds]
#         # puts "second: [expr {$end -$start}]"
#         # puts "Sum: [tsv::get myarray sum]"
#         # puts "Above is the result of second thread"

#     }
# }

# proc t3 {} {
#     thread::create {
#         # set start [clock microseconds]
#         # puts "Entering first thread"
#         package require sqlite3
#         sqlite3 db3 syn_data
#         set res [db3 eval {SELECT SUM(id) FROM contracts WHERE id BETWEEN 521245 AND 781867 }]
#         tsv::incr myarray sum $res
#         # set end [clock microseconds]
#         # puts "third: [expr {$end -$start}]"
#         # puts "Sum: [tsv::get myarray sum]"
#         # puts "Above is the result of third thread"

#     }
# }

proc t4 {} {
    thread::create {
        set start [clock microseconds]
        # puts "Entering first thread"
        package require sqlite3
        sqlite3 db4 syn_data
        set res [db4 eval {SELECT SUM(id) FROM contracts WHERE id BETWEEN 521246 AND 1042491 }]
        tsv::incr myarray sum $res
        set end [clock microseconds]
        puts "fourth: [expr {$end -$start}]"
        puts "Sum: [tsv::get myarray sum]"
        puts "Above is the result of fourth thread"

    }
}

t1
t4
set end [clock microseconds]
puts "Time: [expr {$end -$start}]"


############################################################################################
#Normal operation
#
###########################################################################################
# package require profiler
# profiler::init
set start [clock microseconds]
proc norm {} {
    package require sqlite3
    sqlite3 db1 syn_data
    puts "sum: [db1 eval {SELECT SUM(id) FROM contracts}]"
}
norm
set end [clock microseconds]
puts "Time: [expr {$end -$start}]"
# for {set i 0} {$i < 2} {incr i} {
#     norm
# }
# puts [profiler::print]

#####################################################################################
#Comment region that can be used later
####################################################################################
package require sqlite3
sqlite3 db1 syn_data
db1 eval {
    create table contracts (
                            id INTEGER PRIMARY KEY,


                            first_name CHAR,
                            last_name  CHAR
                            )
}
puts "created"

package require sqlite3
sqlite3 db1 syn_data
for {set i 0} {$i < 50000000} {incr i} {
    db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai") }
}

puts "completed"

# thread::create {
#     puts "Entering second thread"
#     package require sqlite3
#     sqlite3 db3 syn_data
#     puts [db3 eval {SELECT count(*) FROM contacts}]
#     puts "Above is the result of second thread"
# }

# thread::create {
#     puts "Entering third thread"
#     package require sqlite3
#     sqlite3 db4 syn_data
#     puts [db4 eval {SELECT SUM(id) FROM contacts GROUP BY last_name}]
#     puts "Above is the result of third thread"
# }

# puts "Sum: [tsv::get myarray sum]"
###############################################################################################################
##Create 10 database files
##############################################################################################################
package require sqlite3
for {set i 0} {$i <11} {incr i} {
    sqlite3 db1 /home/sai/database/sharding-test/syn_data$i
    db1 eval {
        create table contracts (
                               id INTEGER,
                               first_name CHAR,
                               last_name  CHAR
                               )
    }
    for {set i 0} {$i < 104250} {incr i} {
        if {$i == 104249} {
            db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
        db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
    }
}

