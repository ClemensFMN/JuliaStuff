using Distributions

immutable MultinomialSampler2 <: Sampleable{Multivariate,Discrete}
    n::Int
    prob::Vector{Float64}
end


function Distributions._rand!{T<:Real}(s::MultinomialSampler2, x::AbstractVector{T})
    return [1,2]
end

Distributions.length(s::MultinomialSampler2) = 2



p=MultinomialSampler2(1,[0.2,0.8])
rand(p)
