

function func1(x)
  return x*x
end

dct = {i => func1(i) for i=0:10}


println(dct)

println(dct[3])

