#!/usr/bin/env tclsh

package require profiler

profiler::init

package require sqlite3
sqlite3 db1 syn_data
puts [db1 eval {SELECT SUM(id) FROM contacts GROUP BY first_name }]
# proc p1 {num} {
#     append num $num
#     return [expr $num+1]
# }
# proc p2 {num} {
#     return [expr {$num*10+$num+1}]
# }
# for {set i 0} {$i < 100} {incr i} {
#     p1 1
#     p2 1
# }
puts [profiler::print]
{*}$argv
