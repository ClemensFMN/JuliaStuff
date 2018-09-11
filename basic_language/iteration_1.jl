lst = range(0,stop=1,length=11)

# linspace creates an object not a vector
println(lst)

# the vector creation can be enforced via collect
println(collect(lst))


# the standard(?) idiom to iterate over a list AND requiring the index of the element
for (ind, val) in enumerate(lst)
    println(ind, " -> ", val)
end