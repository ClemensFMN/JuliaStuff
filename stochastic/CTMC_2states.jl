using Distributions

# we have a CTMC with two states, 1 and 2.
# going from 1->2 happens with rate a,
# going from 2->1 happens with rate b
a = 1.5
b = 0.8

pa = Exponential(a)
pb = Exponential(b)


N = 10_000

# we first create a sample of length N from the CTMC
# we store the sequence of states in this vector
statevec = zeros(N+1)
# and the times these changes happen in this vector
# the state is statevec[k] from timevec[k] to timevec[k+1]
timevec = zeros(N+1)

# starting in state 1
statevec[1] = 1

# the MC is a bit special as we only move from 1 to 2 & back
for k = 2:2:N
	statevec[k] = 2
	timevec[k] = rand(pa) + timevec[k-1]
	statevec[k+1] = 1
	timevec[k+1] = rand(pb) + timevec[k]
end

# now we sample the CTMC state at regular time points and note down the state the chain is in 
count_1 = 0
count_2 = 0

delta = 0.1

tmax = maximum(timevec)

l_resvec = ceil(Int, tmax / delta)
resvec = zeros(l_resvec)

for k=1:l_resvec
	t = k*delta # the timepoint we look at
	ind = findlast(x -> x < t, timevec) # find the corresponding state the chain is at time t
	resvec[k] = statevec[ind]
end

# count how often we are in state 1 & compare with analytical result
println(count(x -> x == 1, resvec) / l_resvec)
println(a / (a+b))

println(count(x -> x == 2, resvec) / l_resvec)
println(b / (a+b))
