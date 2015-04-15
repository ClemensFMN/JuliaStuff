# based on https://github.com/QuantEcon/QuantEcon.jl/blob/master/src/mc_tools.jl

type MarkovChain
    p::Matrix # valid stochastic matrix

    function MarkovChain{T}(p::Matrix{T})
        n,m = size(p)

        n != m && throw(ArgumentError("stochastic matrix must be square"))
        any(p .< 0) &&
            throw(ArgumentError("stochastic matrix must have nonnegative elements"))
        #isapprox(sum(p,2),one(T)) ||
        #    throw(ArgumentError("stochastic matrix rows must sum to 1"))
        new(p)
    end
end


n_states(mc::MarkovChain) = size(mc.p,1)

# mc_sample_path()
# simulate a discrete markov chain starting from some initial value
# mc::MarkovChain
# init::Int initial state (default: choose an initial state at random)
# sample_size::Int number of samples to output (default: 1000)
function mc_sample_path(mc::MarkovChain,
                        init::Int=rand(1:n_states(mc)),
                        sample_size::Int=1000)
    p       = float(mc.p) # ensure floating point input for Categorical()
    dist    = [Categorical(vec(p[i,:])) for i=1:n_states(mc)]
    println(dist)
    samples = Array(Int,sample_size+1) # +1 extra for the init
    samples[1] = init
    for t=2:length(samples)
        last = samples[t-1]
        samples[t]= rand(dist[last])
    end
    samples
end



mc = MarkovChain([0.2 0.8; 0.5 0.5])

N = 10000

pth = mc_sample_path(mc, 1, N)

# number of ones
println(sum(pth.==1))
# number of twos
println(sum(pth.==2))

# we seem to have a fixed point near 0.38 0.62
[0.38 0.62] * mc.p
