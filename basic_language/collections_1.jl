# ARRAYS
# ======

lst = collect(4:10)

# index is one-based
println(lst[1])

push!(lst, 100)
println(lst)

# assignment -> create (additional) reference, NO copy
lst2 = lst
lst2[1] = -1
println(lst, lst2)

lst3 = copy(lst)
lst[1] = -2
println(lst, lst3)


# findall(pred,xs) searches for stuff in xs for which pred x returns true
ind = findall(x->x==5, lst)
println(ind)

ind = findall(x->x >7, lst)
println(ind)

# higher-order functions
res = map(x -> x*x, lst)
println(res)

res = filter(x -> x > 50, res)
println(res)

res = broadcast(x->x+2, res)
println(res)

# snytactic sugar for broadcast (instead of using lambdas)
res2 = res .+ 2
println(res)

val = reduce((x,acc)->x + acc, lst)
println(sum(lst), "...", val)
