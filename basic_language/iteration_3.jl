# something a bit more advanced: creating Fibonacci numbers
struct Fib
    maxval::Int
end


function Base.iterate(F::Fib, state=(1,1))
  xn, xnm1 = state
  xnew = xn + xnm1
  if(xnew > F.maxval) # we are above the max value
    nothing # -> return nothing to indicate we are done
  else
    (xnew, (xnew, xn)) # otherwise, return value and new state
  end
end


for i in Fib(100)
    println(i)
end
