module MarkovStuff

export mc_sample_path


using Distributions

"""

    function mc_sample_path(P; init=1, stop=[], sample_size=1000)

Generate a sample path from a Markov chain

# Arguments
- P: State transition probability matrix
- init: Initial state
- stop: List of states; the chain will stop when it reaches one of them
- sample_size: Number of samples to generate if above stop condition is ot reached


"""

function mc_sample_path(P; init=1, stop=[], sample_size=1000)
    X = zeros(Int8, sample_size) # allocate memory
    X[1] = init
    # === convert each row of P into a distribution === #
    n = size(P)[1]
    P_dist = [Categorical(vec(P[i,:])) for i in 1:n]

    # === generate the sample path === #
    for t in 1:(sample_size - 1)
        newval = rand(P_dist[X[t]])
        X[t+1] = newval
        if(newval in stop) # stop when current sample = stop value(s)
            return X[1:t+1] # and return the truncated state sequence
        end
    end
    return X
end


end
