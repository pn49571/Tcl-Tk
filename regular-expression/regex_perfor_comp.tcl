set n 100000
set start [clock microseconds]
package require sqlite3
sqlite db1 /home/sai.cumbulam/development/tcl/development.sqlite3
db1 function regexp regu
puts [db1 eval {SELECT NM_BEDS_TOTAL from providermaster WHERE REGEXP(NM_BEDS_TOTAL)}]
set end [clock microseconds]
#puts "[expr {($end - $start)}] microseconds"
puts "[expr {($end -$start)}] microseconds"

proc regu {arg} {
    set a [regexp {([a-zA-Z])} "$arg"]
    return $a
}
