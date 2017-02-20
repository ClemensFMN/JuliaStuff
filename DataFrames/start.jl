using DataFrames


x = linspace(-2,2,50)
y1 = x.^2
y2 = x.^3


df = DataFrame(x=x, f1=y1, f2=y2)

describe(df)

println(names(df))
println(df[:x])
println(size(df))
