using DataFrames, Query

df = DataFrame(name=["John", "Sally", "Kirk"], age=[23., 42., 59.], children=[3,2,2])
x = @from i in df begin
    @group i by i.children into g # group by the number of children
    @select {NumChildren=key(g),Count=length(g)}
    @collect DataFrame
end
println(x)

# we can use this to obtain a histogram; i.e. counting how often each value from df occurs
df = DataFrame(x = [1,2,3,1,1,5,2])
x = @from i in df begin
    @group i by i.x into g
    @select {Value = key(g), Count = length(g)}
    @collect DataFrame
end
println(x)

# same but collect result in a list (instead of DataFrame)
x = @from i in df begin
    @group i by i.x into g
    @select {Value = key(g), Count = length(g)}
    @collect
end
println(x)

s = "the yellow cat runs after the red cat and the blue mouse hides from the yellow cat"
df = DataFrame(x = split(s))
# collect result in a dictionary
x = @from i in df begin
    @group i by i.x into g
    @select {Value = key(g), Count = length(g)}
    @collect Dict
end
println(x)

