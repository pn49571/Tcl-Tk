load /home/sai/Downloads/libtclpy-master/libtclpy.so
py eval {from rpy2.robjects import r}
py eval {r('x <- rnorm(100)')}
py eval {r('y <- x + rnorm(100,sd=0.5)')}
py eval {r('plot(x,y)')}
puts [py eval {r('pi[1]')}]

