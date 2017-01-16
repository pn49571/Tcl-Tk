package require Thread 2.0 
set id [thread::create { 
  puts "sai"                       
  do_init 
  thread::wait 
}]


thread::send -async $id {thread::exit}
