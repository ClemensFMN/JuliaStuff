using Distributions

# based on https://github.com/QuantEcon/QuantEcon.jl/blob/master/src/mc_tools.jl

immutable type MarkovChain
    p::Matrix # valid stochastic matrix

    function MarkovChain{T}(p::Matrix{T})
        n,m = size(p)

        n != m && throw(ArgumentError("stochastic matrix must be square"))
        
        any(p .< 0) &&
            throw(ArgumentError("stochastic matrix must have nonnegative elements"))
        
        if(all(map(x->isapprox(x,1), sum(p, 2))) )
            error("stochastic matrix rows must sum to 1")
        end
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



mc = MarkovChain([0.2 0.4 0.4; 0.45 0.1 0.45; 0.7 0.2 0.1])

N = 10000

pth = mc_sample_path(mc, 1, N)


for i in 1:n_states(mc)
    println(i, "   ", sum(pth.==i)/N)
end


eigval, eigvec = eig(mc.p')
# find the eigenvector belonging to the eigenval of 1
isunit = map(x->isapprox(x,1), eigval)
e1 = real(eigvec[:,isunit])
e1./sum(e1)
