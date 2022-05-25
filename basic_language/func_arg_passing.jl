function f1(lst :: Array{Int, 1})
    # we pass an array to a function
    lst[1] = 10 # and modify the array in the function
    return(sum(lst))
end


a1 = [1,2,3,4,5]
@show a1
res = f1(a1)
@show a1, res # this modification inside the function affects the array in the outer scope as well...
