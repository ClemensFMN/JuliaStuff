lst = 4:10

# findin(a,b) searches for stuff in a that's in b
# if b is a single element, it returns all indices in a where the elemtn appears
ind = findin(lst, 6)
println(ind)

ind = findin(lst, 2)
println(ind)

# list comprehension stuff (see more below)
lst = [x.^2 for x in -5:5]
ind = findin(lst, 4)
println(lst, "...", ind)

# find takes a predicate function and returns the indices of the array where this function returns true
ind = find(x->x<5, lst)
println(ind)

val = reduce((x,acc)->x + acc, 0, lst)
println(sum(lst), "...", val)


# List Comprehensions
# lst looks much nicer in the REPL
lst = [(x, x.^2) for x in -5:5]
println(lst)

lst = [(r,c) for r in 1:3, c in 1:3]
println(lst)

lst = [r+c for r in 1:3, c in 1:3]
println(lst)
lst
