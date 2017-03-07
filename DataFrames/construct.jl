using DataFrames

# create empty dataframes
# 2 columns names x & y, each taking Float64s and 5 rows
df1 = DataFrame([Float64, Float64], [:x, :y], 5)

# everything float, 10 x 2 dimension, "default" names
df2 = DataFrame(Float64, 10, 2)

# accessing elements
println(df1[1,:])

# setting elements
df1[1,:x] = 10
df1[1,:y] = 20

println(df1)
