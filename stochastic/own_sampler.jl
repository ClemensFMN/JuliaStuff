# creating own samplers in the Distributions.jl framework...
using Distributions

# a simple univariate and discrete distribution for a uniform distribution between 0 and par
struct SimpleDist <: Sampleable{Univariate,Discrete}
    par::Int # takes one parameter
end

# implementing the sampling function
function Distributions.rand(S::SimpleDist)
  # setting up a uniform dist between 0 and par
  p = Distributions.DiscreteUniform(0,S.par)
  # and sampling from it...
  val = Distributions.rand(p)
  return(val)
end


# instantiate such a SimpleDist
maxVal = 4
p = SimpleDist(maxVal)

# print a couple of values for fun
for i in 1:10
    println(rand(p))
end

# and draw N RVs from SimpleDist
N = 100_000

# and make a simple histogram
vls = rand(p, N)
for i in 0:maxVal
  ind = findall(x->x==i, vls)
  println(i, "...", length(ind)/N)
end
