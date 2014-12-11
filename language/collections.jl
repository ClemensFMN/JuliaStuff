

lst = [0,2,3,5,0,7,2,1]


collect(enumerate(lst))


# filter elements of the collection
println(filter(x->x>4, lst))


# find the index of lst's non-zero elements
println(find(lst))


# find the index of lst where f is true
println(find(x->x>4,lst))
