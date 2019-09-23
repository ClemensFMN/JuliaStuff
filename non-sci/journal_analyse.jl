using Plots
plotly()
using DataFrames, Query
using Dates

# this script counts the number of journal entries per month

fls = readdir("/home/clnovak/src/latex/Journal")
# we use DataFrames with Query framework to store / analyse the data
df = DataFrame(year = Int[], month = Int[], day = Int[], pres = Int[])


for fl in fls # run through all files in the journal dir
    m = match(r"(\d+)-(\d+)-(\d+)", fl) # consider only files starting with yyyy-mm-dd; i.e. journal entries
    if(m != nothing)
        year, month, day = map(s -> parse(Int, s), m.captures)
        push!(df, (year, month, day, 1)) # push the row into the dataframe
    end
end

x = @from i in df begin
    @group i by Date(i.year, i.month) into g # group the data by date (consisting of year+month), this counts the entries of this month
    @select {Key = key(g), Count=length(g)} # and output the date + count...
    @collect DataFrame # ... in a new DataFrame
end


println(x)
bar(x.Key, x.Count) # plot the thing. Using Date as x-axis provides the proper labels of the bar plot


