# creating own samplers in the Distributions.jl framework...
using Distributions

# a simple univariate and discrete distribution
type SimpleDist <: Sampleable{Univariate, Discrete}
    par::Int # takes one parameter
end

# and implements a sampling function...
function rand(S::SimpleDist)
    # this also works without providing the namespace
    p = Distributions.DiscreteUniform(0,S.par)
    # but this REQUIRES the namespace
    val = Distributions.rand(p)
    # like this one
    #val = Base.rand(1:S.par)
    return(val)
end


p = SimpleDist(4)

for i in 1:10
    println(rand(p))
end


# something a bit more advanced: a multivariate discrete sampler
# which does not yet work...
type CorrDice <: Sampleable{Multivariate, Discrete}
end

# length of each sample is two
Base.length(S::CorrDice) = 2


function _rand!{T<:Real}(S::CorrDice, x::AbstractVector{T})
    return(1,1)
end


p = CorrDice()
Distributions.rand(p)
