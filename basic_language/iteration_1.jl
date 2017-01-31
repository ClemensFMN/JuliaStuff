lst = linspace(0,1,21)

# linspace creates an object not a vector
println(lst)

# the vector creation can be enforced via collect
println(collect(lst))


# the standard(?) idiom to iterate over a list AND requiring the index of the element
for (ind, val) in enumerate(lst)
    println(ind, " -> ", val)
end