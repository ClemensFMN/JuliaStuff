using DataFrames

# populate a DataFrame with precalculated data
x = linspace(-2,2,50)
y1 = x.^2
y2 = x.^3


df = DataFrame(x=x, f1=y1, f2=y2)

describe(df)

println(names(df))
println(df[:x])
println(size(df))

# making queries on the data
println(df[df[:x] .> 0,:])

# applying functions column-wise to the data
println(colwise(mean, df))
