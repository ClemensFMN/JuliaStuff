struct ContFrac
   coeffs::Array{Int64,1}
end


function val(c::ContFrac)
   res = last(c.coeffs)
   work = reverse(c.coeffs)
   for el in work[2:end]
      res = 1/res + el
   end
   return(res)
end

# obtain the fractional part of a number
fractPart(x) = x - floor(x)

# convert a number to a continued fraction
function toContFrac(x::Real)
   res = []
   fpart = fractPart(x)
   while(abs(fpart) > 1e-5)
      append!(res, floor(x))
      x = 1 / fpart
      fpart = fractPart(x)
   end
   append!(res, floor(x))
   res
end


truncNumber(x,ndigits) = floor(pi*10^ndigits) / 10^ndigits

# there are some rather ugly numerical problems here...
c=ContFrac([3,4,12,3])
println(val(c))

res1 = toContFrac(val(c))
println(res1)

approx1 = 3.1415926
res2 = toContFrac(approx1)
println(res2)


