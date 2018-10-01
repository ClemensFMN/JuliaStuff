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


foo(2+3) # the function never sees the expression -> 2+3 is evaluated riht away
@foo2(2+3) # the macro gets the expression 2+3 and can whatever it wants with it

