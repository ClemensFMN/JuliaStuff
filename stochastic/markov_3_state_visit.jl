using Distributions
using IterTools
using LinearAlgebra

include("MarkovStuff.jl")
import .MarkovStuff


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
    stateSeq = MarkovStuff.mc_sample_path(P, init=1, stop=4) # start at 1, stop at 4
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
