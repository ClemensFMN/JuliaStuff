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
        if(newval in stop) # stop when current sample = stop value(s)
            return X[1:t+1] # and return the truncated state sequence
        end
    end
    return X
end


# 5 state MC with absorbing states 4 & 5
P = [0   0.2 0.8 0   0;
     0.4 0   0.1 0.3 0.2;
     0.2 0.1 0   0.1 0.6;
     0   0   0   1   0;
     0   0   0   0   1]


# how often do we end in a recurrent state?
RUNS = 10000
recState = zeros(Int8, RUNS)


for i in 1:RUNS
    stateSeq = mc_sample_path(P, init=3, stop=[4,5]) # staring in init, stopping in either 4 or 5
    recState[i] = stateSeq[end]
end

println("absorption prob for state 4: ", length(findall(x->x==4, recState)) / RUNS)
println("absorption prob for state 5: ", length(findall(x->x==5, recState)) / RUNS)



# states 4,5 are recurrent, extract the transition probabilities of the transient states
# extract 
T = P[1:3,1:3]
# calculate the absorption probabilities.
B = P[1:3,4:5]
A = inv(Matrix{Float64}(I,3,3)-T)*B

println(A)

