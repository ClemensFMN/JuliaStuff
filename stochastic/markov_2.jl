using Distributions
using IterTools

include("MarkovStuff.jl")
import .MarkovStuff

p1 = 0.15
p2 = 0.3
P = [p1 1-p1; 1-p2 p2]
N = 1000000

stateSeq = MarkovStuff.mc_sample_path(P, sample_size=N)

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
println(length(findall(x->x==1, stateSeq))/N)
println(length(findall(x->x==2, stateSeq))/N)

P^10
