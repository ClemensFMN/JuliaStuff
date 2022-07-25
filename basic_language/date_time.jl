using Dates


t1=Time("12:10")
t2=Time("13:20")

println(t2-t1)
println(Time(t2-t1))

d1=Date("1-5-2010", dateformat"d-m-y")
d2=Date("3-7-2010", dateformat"d-m-y")
@show d2-d1



@show Date("1-3-2010", dateformat"d-m-y") - Date("1-2-2010", dateformat"d-m-y")
@show Date("1-3-2012", dateformat"d-m-y") - Date("1-2-2012", dateformat"d-m-y")

@show isleapyear(2010)
@show isleapyear(2012)

