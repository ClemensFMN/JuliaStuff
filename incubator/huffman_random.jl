using Distributions
include("huffman.jl")

function oneRun(N)

    p = Uniform(0,1)

    ps = rand(p, N)
    ps = ps ./ sum(ps)
    # @show ps

    frq = Dict(zip(1:N, ps))
    tree = huffmantree(frq)

    dct = getencoding(tree, "", Dict{Int, String}())
    # @show dct

    # avl = avgcl(frq, dct)
    stat = cw_stats(frq, dct)
    # @show avl
    # @show entropy(values(frq))
    # (avl, entropy(values(frq)))
    (stat, entropy(values(frq)))
end

RUNS = 10000
N = 32

stat = zeros(3, RUNS)
H = zeros(RUNS)

for iter = 1:RUNS
    (stat[:,iter], H[iter]) = oneRun(N)
end

@show log(2, N)
@show mean(stat[1,:])
@show mean(H)
@show mean((stat[1,:] .- H) ./ H)
@show maximum(stat[2,:])
@show minimum(stat[3,:])



