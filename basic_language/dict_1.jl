function func1(x)
  return x*x
end



# method 1 to create a dict is explicitely via the constructor
d1 = Dict(1 => "A", 2 => "B", 4 => "C")

println(d1)
println(d1[2])
println(keys(d1))

# get takes a default value
println(get(d1, 1, "XXX"))
println(get(d1, 3, "XXX"))

# get! uses default values and updates the dictionary when the key is not found
get!(d1, 1, "XXX")
println(d1)

get!(d1, 3, "XXX")
println(d1)

# methid 2 to create a dict

d2 = Dict(i => func1(i) for i=0:10)
println(d2)
