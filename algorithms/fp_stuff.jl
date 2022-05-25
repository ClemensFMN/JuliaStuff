function partitionBy(pred, xs)
    keys = unique(map(pred, xs))
    res = Dict{eltype(xs), typeof(keys)}() 
    for k in keys
        res[k] = filter(x -> pred(x) == k, xs)
    end
    res
end

# partitionBy(x->x%2, collect(1:10))
# Dict{Int64,Array{Int64,1}} with 2 entries:
#   0 => [2, 4, 6, 8, 10]
#   1 => [1, 3, 5, 7, 9]

function mapIndexed(f, xs)
    res = [f(ind, val) for (ind, val) in enumerate(xs)]    
end

#julia> mapIndexed((i,x) -> (i,x), 1:4)
#4-element Array{Tuple{Int64,Int64},1}:
# (1, 1)
# (2, 2)
# (3, 3)
# (4, 4)
