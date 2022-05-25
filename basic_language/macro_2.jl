function foo(x)
  @show x
  x
end


macro foo2(x)
  @show x
  @show x.args
  x.args[1] = :- # the macro can change the handed-over expression...
  x
end

# a simple macro taking two expressions. The macro prints out both of them and 
# evaluates whether the expressions yield the same value
macro myassert(x, y) 
  println("Left expression: $x")
  println("Right expression: $y")
  :($x == $y)
end



foo(2+3) # the function never sees the expression -> 2+3 is evaluated riht away
@foo2(2+3) # the macro gets the expression 2+3 and can whatever it wants with it

# some test function for our myassert macro
f1(x) = x+1
@myassert(f1(3), 4)