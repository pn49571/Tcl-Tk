package require sqlite3
sqlite3 db1 /home/sai/database/regex
db1 eval {SELECT sqlite_compileoption_used('ENABLE_LOAD_EXTENSION');}
db1 eval {SELECT load_extension('/home/sai/system_files/pcre.so'); }
puts [db1 eval {SELECT * FROM COMPANY WHERE id REGEXP '\d'; }]
