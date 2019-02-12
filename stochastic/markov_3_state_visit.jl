using Distributions
using IterTools
using LinearAlgebra

# function for generating a sequence from a markov chain. it generates sample_size states or
# stops when the current state = stop
function mc_sample_path(P; init=1, stop=-1, sample_size=1000)
    X = zeros(Int8, sample_size) # allocate memory
    X[1] = init
    # === convert each row of P into a distribution === #
    n = size(P)[1]
    P_dist = [Categorical(vec(P[i,:])) for i in 1:n]

    # === generate the sample path === #
    for t in 1:(sample_size - 1)
        newval = rand(P_dist[X[t]])
        X[t+1] = newval
        if(newval == stop) # stop when current sample = stop value
            return X[1:t+1] # and return the truncated state sequence
        end
    end
    return X
end


# 4 state MC with absorbing state 4
P = [0   0.2 0.8 0;
     0.4 0   0.3 0.3;
     0.2 0.3 0   0.5;
     0   0   0   1]


# how often are we in a certain state?
countState = 2
RUNS = 10000
meanStateVisit = zeros(Int8, RUNS)


for i in 1:RUNS
    stateSeq = mc_sample_path(P, init=1, stop=4) # start at 1, stop at 4
    meanStateVisit[i] = length(findall(x->x==countState, stateSeq)) 
end

# state 4 is recurrent, extract the transition probabilities of the transient states
# extract 
T = P[1:3,1:3]
# and calculate the fundamental matrix
# where element s_ij contains the expected number of times we are in state j when started in state i
S = inv(Matrix{Float64}(I,3,3)-T)


println("analytic: ", S[1,countState], " simulation: ", mean(meanStateVisit))

# just out of curiosity, calculate the absorption probabilities.
B = P[1:3,4]
A = inv(Matrix{Float64}(I,3,3)-T)*B
# where A is a length-3 column vector of ones; i.e. state 4 absorbs all 3 transient states with prob. 1 (no na)
println(A)
