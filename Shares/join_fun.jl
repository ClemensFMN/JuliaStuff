using DataFrames

# assume we have two tables with time series
# ID is actually a date
# i.e. for date = 1 we have values,
# but at date=2, only set a has a vaue and at date=3, only set b has a value

a=DataFrame(ID=[1,2], Val=[10,12]);
b=DataFrame(ID=[1,3], Val=[20,30]);

# to get a table with all dates (even if they are missing in one of the series), we use an outer join
jout = join(a,b,on=:ID,kind=:outer)
println(jout)

# the other side is a table which contain only values which are contained in both tables
jin = join(a,b,on=:ID,kind=:inner)
println(jin)