# some stuff to help with continued fractions
# we represent them as Array of integers
struct ContFrac
   coeffs::Array{Int64,1}
end

# calculating a real number from a continued fraction
function val(c::ContFrac)
   res = last(c.coeffs)
   work = reverse(c.coeffs)
   for el in work[2:end]
      res = 1/res + el
   end
   return(res)
end

# calculating a fraction from a cf
function toFraction(c::ContFrac)
   res = last(c.coeffs)
   work = reverse(c.coeffs)
   for el in work[2:end]
      res = 1//res + el
   end
   return(res)
end


# obtain the fractional part of a number
fractPart(x) = x - floor(x)

# convert a real number to a continued fraction
# we have numerical issues here
function toContFrac(x::Real)
   res = []
   fpart = fractPart(x)
   while(abs(fpart) > 1e-5) # to be exact, HERE are the numerical issues
      append!(res, floor(x))
      x = 1 / fpart
      fpart = fractPart(x)
   end
   append!(res, floor(x))
   ContFrac(res)
end

# convert a fraction to a cf
function toContFrac(x::Rational)
   res = []
   fpart = fractPart(x)
   while(fpart != 0)
      append!(res, floor(x))
      x = 1 / fpart
      fpart = fractPart(x)
   end
   append!(res, floor(x))
   ContFrac(res)
end


# truncate a number to the first n digits 
truncNumber(x,ndigits) = floor(pi*10^ndigits) / 10^ndigits

c = ContFrac([3,4,12,3])
valC = val(c)
println("real number: ", valC)
println("as fraction: ", toFraction(c))

# here comes the messy numeric part...
res1 = toContFrac(valC)
println("cont. frac. from real: ", res1)

res2 = toContFrac(220//68)
println(res2)

approx1 = 3.1415926530119025
res2 = toContFrac(approx1)
println(res2.coeffs)

println("pi approx based on [3,7,15,1,292]: ", val(ContFrac([3,7,15,1,292])))

