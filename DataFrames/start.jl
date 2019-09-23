using DataFrames
using Statistics

# populate a DataFrame with precalculated data
x = range(-2,2,length=10)
y1 = x.^2
y2 = x.^3


df = DataFrame(x=x, f1=y1, f2=y2)

println(describe(df))
println(size(df))
println(names(df))

println(df[!, :x]) # yields a vector
println(df[!, [:x, :f1]]) # yields a DataFrame - can use more than one column


# making queries on the data
println(df[df.x.> 0,:])

# applying functions column-wise to the data
println(mean(df.x))
println(aggregate(df, sum))
