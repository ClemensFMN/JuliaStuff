# List Comprehensions

# create an array of tuples
lst = [(x, x.^2) for x in -5:5]
println(lst)

# and build up a matrix
lst = [r+c for r in 1:3, c in 1:3]
println(lst)
