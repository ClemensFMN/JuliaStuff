

lst = [1,2,3,5,0,2,0,1]

println(lst)


# vector with 
#    zeros at positions where lst is neither 0 or 5
#    ones at positions where lst is 0
#    twos at positions where lst is 5
vc = indexin(lst, [0,5])
println(vc)

# return indizes where lst = 0
vc = findin(lst, [0])
println(vc)


vc = filter(x->x>2, lst)
println(vc)

println(findmax(lst))

# are all elements of lst even?
println(all(x->x%2==0, lst))

# at least one even?
println(any(x->x%2==0, lst))

