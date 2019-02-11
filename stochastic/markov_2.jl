using Distributions
using IterTools

# function for generating a sequence from a markov chain
function mc_sample_path(P; init=1, sample_size=1000)
    X = zeros(Int8, sample_size) # allocate memory
    X[1] = init
    # === convert each row of P into a distribution === #
    n = size(P)[1]
    P_dist = [Categorical(vec(P[i,:])) for i in 1:n]

    # === generate the sample path === #
    for t in 1:(sample_size - 1)
        X[t+1] = rand(P_dist[X[t]])
    end
    return X
end

# simulate an MC with two states 0 & 1
# p(1|1) = p1 & p(2|1) = 1-p1
# p(2|2) = p2 & p(1|2) = 1-p2


p1 = 0.15
p2 = 0.3
P = [p1 1-p1; 1-p2 p2]
N = 1000000

stateSeq = mc_sample_path(P, sample_size=N)

# we are interested in the average length of 0- and 1-sequences
# first we group the state sequence into groups of the same value
cnt = collect(groupby(x->x, stateSeq))
# then we obtain the length of each such group
stateDuration = map(x->(x[1], length(x)), cnt)
# obtain the length of the 0- and 1-sequences
zeroLength = map(x->x[2], filter(x->x[1]==1, stateDuration))
oneLength = map(x->x[2], filter(x->x[1]==2, stateDuration))

# in case of asymmetric MCs, the mean lengths of ones and zeros are different
println("mean length of zero sequences ", mean(zeroLength), "\nmean length of one sequences ", mean(oneLength))
# as is shown here...
println("analytical ", p1/(1-p1), "  ", p2/(1-p2))

# obtain the total number of 0s and 1s...
#println(length(findall(x->x==1, stateSeq))/N)
#println(length(findall(x->x==2, stateSeq))/N)

# d,v=eig(P')
# println("analytical ", v[:,2]/sum(v[:,2]))
