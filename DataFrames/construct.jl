using DataFrames

# create empty dataframes
# 2 columns names x & y, each taking Float64s and 5 rows
df1 = DataFrame([Float64, Float64], [:x, :y], 5)

# accessing elements
println(df1[1,:])

# setting elements
df1[1,:x] = 10
df1[1,:y] = 20
println(df1)


df2 = DataFrame([Float64, Float64], [:x, :y])
push!(df2, (1,2))
push!(df2, (3,4))
println(df2)
