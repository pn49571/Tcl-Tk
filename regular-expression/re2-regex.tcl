load /home/sai/swig/exampc++/copy.so
#####################################################################
##regexp
####################################################################
package require profiler
profiler::init

proc regu {arg} {
    set a [regexp {(sai[a-z]+)} "$arg"]
    return $a
}

proc test {} {
    package require sqlite3
    sqlite3 db1 syn_data
    db1 function regexp regu
    # db1 function regexp -deterministic {regexp --}
    set result [db1 eval { SELECT *  FROM contracts WHERE regexp(first_name) } ]
    puts $result
}
test
puts [profiler::print]


#####################################################################
##re2
####################################################################
package require profiler
profiler::init

proc regu {arg} {
    set a [regular $arg s.*f]
    return $a
}

proc test1 {} {
    package require sqlite3
    sqlite3 db1 syn_data
    # db1 function regexp -deterministic {regular1 --}
    db1 function regexp regu
    set result [db1 eval { SELECT * FROM contracts WHERE regexp(first_name)='t'}]
    # set result [db1 eval { SELECT regexp('hi')}]
    puts $result
}
test1
puts [profiler::print]


#####################################################################
##re2
####################################################################
package require profiler
profiler::init

# proc regu {arg} {
#     set a [regular $arg s.*f]
#     return $a
# }

proc test1 {} {
    package require sqlite3
    sqlite3 db1 syn_data
    db1 function regexp -argcount 3 {regular --}
    # db1 function regexp regu
    set result [db1 eval { SELECT * FROM contracts WHERE first_name REGEXP 'sai'}]
    # set result [db1 eval { SELECT regexp('hi')}]
    puts $result
}
test1
puts [profiler::print]

