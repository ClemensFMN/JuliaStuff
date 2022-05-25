using Test

include("fp_stuff.jl")

@testset "partitionBy" begin

lst = collect(1:10)

res1 = partitionBy(x -> x%2, lst)

@test res1[0] == [2,4,6,8,10]
@test res1[1] == [1,3,5,7,9]

@test length(res1[0]) + length(res[1]) == length(lst)

end
