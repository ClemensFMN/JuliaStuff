using Distributions

# we consider a categorial distribution with 2 elements (-1,1) where P(-1) = p
# let's draw N such RVs, sum them up and look at the distribution of the sum
# we do that with a OGF (maxima)

p = 0.3
N = 4 # number of RVs we sum over
RUNS = 100000 # we do things in one batch; i.e. generate N pairs of RVs

pdist = Categorical([p, 1-p])
# categorial produces RVs with values 1,2,3...
# to get into the -1, 1 range we need to shift/scale
x = 2 .* rand(pdist, (RUNS,N)) .- 3

# now we sum across the N realizations
s = sum(x, dims=2)




#c = count(i->i==0, s)
#@show c / RUNS

cnts = [(k, count(i->i==k, s)/RUNS) for k=-N:N]
println(cnts)


# analystical result is
@show 6*p^4 - 12*p^3 + 6*p^2


# f:p*x^(-1) + (1-p)*x;
# e:expand(f^4);
# ev(e,p=0.3);
