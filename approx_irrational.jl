# find rational approximations for an irrational number (pi in this case)
# we consider abs( target - n/d) as error function
function approx(target = pi)

  # we subsequently increase d (up to DMax)
  DMax = 1000

  d = 1
  # in parallel we keep track of the approximation error seen so far
  err_so_far = 1

   
  while(d < DMax)
    # obtain a new approximation
    n = round(target * d)
    # calculate approximation error
    approx_err = abs(n/d - target)
    # only print the new approx if it is better than what we have seen so far
    if(approx_err < err_so_far)
       println(n, "...", d, "...", approx_err)
       err_so_far = approx_err
    end
    d = d + 1
  end
end

approx()
println()
approx(sqrt(2))

