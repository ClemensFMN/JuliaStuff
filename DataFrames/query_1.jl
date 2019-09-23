using DataFrames, Query

df = DataFrame(a=[2,1,1,2,1,3],b=[2,2,1,1,3,2])


x = @from i in df begin
    @where i.a == 1 # filtering
    @select {i.a, NewColName = i.b} # selecting which columns to output & which names the columns should have
    @collect DataFrame
end
println(x)


data = [1,2,3]
x = @from i in data begin
    @select i^2 # simple transformation of data
    @collect
end
println(x)


df1 = DataFrame(jobid = [1,2,5], name= ["Clemens", "Susi", "Peter"], salary = [100, 140, 90])
df2 = DataFrame(id = [1,2,3,4], job=["manager", "QA", "QM", "developer"])

x = @from i in df1 begin
    @join j in df2 on i.jobid equals j.id # inner join -> peter is left out as he has an unkown jobid
    @select {i.name, i.salary, j.job}
    @collect DataFrame
end
println(x)

x = @from i in df1 begin
    @left_outer_join j in df2 on i.jobid equals j.id # left join -> peter is included with job = "missing"
    @select {i.name, i.salary, j.job}
    @collect DataFrame
end

println(x)


