package require sqlite3
for {set i 0} {$i <11} {incr i} {
    sqlite3 db1 /home/sai/database/10-shards/syn_data$i
    db1 eval {
        create table contracts (
                                id INTEGER,
                                first_name CHAR,
                                last_name  CHAR
                                )
    }

}


proc t1 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data1
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
    }
    }
}


proc t2 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data2
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}

proc t3 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data3
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}

proc t4 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data4
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}

proc t5 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data5
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}

proc t6 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data6
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}

proc t7 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data7
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}

proc t8 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data8
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}

proc t9 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data9
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}

proc t10 {} {
    thread::create {
        package require sqlite3
        sqlite3 db1 /home/sai/database/10-shards/syn_data10
        for {set i 0} {$i < 104250} {incr i} {
            if {$i == 104249} {
                db1 eval {INSERT INTO contracts VALUES ($i,"saiisheretypingtheresult","pai")}
            }
            db1 eval {INSERT INTO contracts VALUES ($i,"sai","pai")}
        }
    }
}
