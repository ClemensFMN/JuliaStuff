using Distributions

# based on https://github.com/QuantEcon/QuantEcon.jl/blob/master/src/mc_tools.jl

immutable type MarkovChain
    p::Matrix # valid stochastic matrix

    function MarkovChain{T}(p::Matrix{T})
        n,m = size(p)

        n != m && throw(ArgumentError("stochastic matrix must be square"))
        
        any(p .< 0) &&
            throw(ArgumentError("stochastic matrix must have nonnegative elements"))
        
        if(!all(map(x->isapprox(x,1), sum(p, 2))) )
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

    samples = Array(Int,sample_size+1) # +1 extra for the init
    samples[1] = init
    for t=2:length(samples)
        last = samples[t-1]
        samples[t]= rand(dist[last])
    end
    samples
end


# mc_sample_path_stop()
# simulate a discrete markov chain starting from some initial value till it reaches a defined stop state
# mc::MarkovChain
# init::Int initial state
# stop::Int stop state
function mc_sample_path_stop(mc::MarkovChain, init::Int, stop::Int)
    p       = float(mc.p) # ensure floating point input for Categorical()
    dist    = [Categorical(vec(p[i,:])) for i=1:n_states(mc)]

    samples = [init]

    t = 2

    while true

        last = samples[t-1]
        nw = rand(dist[last])
        samples= [samples, nw]

        if(nw == stop)
            break
        end
        t = t + 1
    end

    return samples, length(samples)

end


# get_steady_probs
# get stationary state distribution of a Markov Chain
function get_steady_probs(mc::MarkovChain)

    eigval, eigvec = eig(mc.p')
    # find the eigenvector belonging to the eigenval of 1
    isunit = map(x->isapprox(x,1), eigval)
    e1 = real(eigvec[:,isunit])
    e1./sum(e1)

end


mc = MarkovChain([0.2 0.4 0.4; 0.45 0.1 0.45; 0.7 0.2 0.1])

N = 100000

# simulate Markov Chain
#pth = mc_sample_path(mc, 1, N)

# and empirically measure the stationary distribution of states
#for i in 1:n_states(mc)
#    println(i, "   ", sum(pth.==i)/N)
#end


start = 1
stop = 3


len_vec = zeros(N)
for i in 1:N

    pth, ln = mc_sample_path_stop(mc, start, stop)
    len_vec[i] = ln

end

println(mean(len_vec))

# the vector of the stationary probs
w = get_steady_probs(mc)
# now as a matrix
W = repeat(w', outer=[n_states(mc), 1])
# the Z matrix is required for calculating the mean first passage time (MFPT)
Z = inv(eye(n_states(mc)) - mc.p + W)

# calculate the mfpt between state "start" & "stop"; i.e. starting in "start",
# after how many steps is the state "stop" reached?
# careful: mc_sample_path_stop counts the number of steps, MFPT is defined as number of
# states => mean(len_vec) = MFPT + 1
mfpt = (Z[stop,stop] - Z[start,stop]) / w[stop]

