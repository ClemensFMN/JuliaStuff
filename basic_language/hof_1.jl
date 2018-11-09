# Some applications for using higher-order functions


# simple function
function f1(x)
  return x+1
end

# a function taking a function f and returning a function applying f twice
function do_twice(f)
  g = x -> f(f(x))
  return(g)
end


h = do_twice(f1)
println(h(1))


function callWithLogging(f, x)
  println("Calling function with value ", x)
  res = f(x)
  println("got result ", res)
  res
end


res = callWithLogging(f1, 3)
println(res)

