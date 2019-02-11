using Distributions
#using IterTools

# simulate a symmetic MC with two states 0 & 1
# p(0|0) = p & p(1|0) = 1-p

p = 0.15

pMC = Bernoulli(p)

N = 100000

stateSeq = zeros(Int8, N)

# start in the zero state (shoud be actually random
stateSeq[1] = 0

for iter=2:N
    r = rand(pMC)
    # @show r
    # the state transitions - could probably be simplified
    if(stateSeq[iter-1]==0 && r==0)
        stateSeq[iter] = 0
    elseif(stateSeq[iter-1]==0 && r==1)
        stateSeq[iter] = 1
    elseif(stateSeq[iter-1]==1 && r==0)
        stateSeq[iter] = 1
    else
        stateSeq[iter] = 0
    end
    #@show stateSeq[iter]
end

#stateSeq

# we are interested in the average length of 0- and 1-sequences
# first we group the state sequence into groups of the same value
cnt = collect(groupby(x->x, stateSeq))
# then we obtain the length of each such group
stateDuration = map(x->(x[1], length(x)), cnt)
# obtain the length of the 0- and 1-sequences
zeroLength = map(x->x[2], filter(x->x[1]==0, stateDuration))
oneLength = map(x->x[2], filter(x->x[1]==1, stateDuration))

println("mean length of zero sequences ", mean(zeroLength), " mean length of one sequences ", mean(oneLength))
println("analytical ", (1-p)/p)

# obtain the total number of 0s and 1s...
println(length(find(x->x==0, stateSeq))/N)
println(length(find(x->x==1, stateSeq))/N)
