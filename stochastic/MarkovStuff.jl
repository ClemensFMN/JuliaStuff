module MarkovStuff

export mc_sample_path


using Distributions

"""
    function mc_sample_path(P; init=1, stop=[], sample_size=1000)

Generate a sample path from a Markov chain and returns it

# Arguments
- P: State transition probability matrix
- init: Initial state
- stop: List of states; the chain will stop when it reaches one of them
- sample_size: Number of samples to generate if stop condition is not reached


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

"""

    function gth_solve!(A::Matrix{T}) where T<:Real

calculate the limiting distribution via Gaussian elimination...
taken from https://github.com/QuantEcon/QuantEcon.jl/blob/master/src/markov/mc_tools.jl
"""
function gth_solve!(A::Matrix{T}) where T<:Real
    n = size(A, 1)
    x = zeros(T, n)

    @inbounds for k in 1:n-1
        scale = sum(A[k, k+1:n])
        if scale <= zero(T)
            # There is one (and only one) recurrent class contained in
            # {1, ..., k};
            # compute the solution associated with that recurrent class.
            n = k
            break
        end
        A[k+1:n, k] /= scale

        for j in k+1:n, i in k+1:n
            A[i, j] += A[i, k] * A[k, j]
        end
    end

    # backsubstitution
    x[n] = 1
    @inbounds for k in n-1:-1:1, i in k+1:n
        x[k] += x[i] * A[i, k]
    end

    # normalisation
    x /= sum(x)

    return x
end





end
