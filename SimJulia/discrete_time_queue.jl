using Distributions


RUNS = 1_000_000

# initial length
N = zeros(RUNS)
p = 1/5
q = 1/2

r = p*(1-q)
s = q*(1-p)


puniform = Uniform(0,1)

N[1] = 2

# transition probs in all but the zero state
# with prob s, we decrease, with prob 1-r-s we stay, with prob r we increase
pnonzero = Categorical([s, 1-r-s, r]) 
pzero = Categorical([1-r, r])
for i in 2:RUNS
	if(N[i-1] > 0)
		 # draw from our transition prob and decrease by two
		 # with prob s delta = -1, with prob 1-r-s delta = 0, with prob r delta = 1
		delta = rand(pnonzero) - 2
	else # same idea, but different delta calculation
		delta = rand(pzero) - 1
	end
	N[i] = N[i-1] + delta # calc the new state
end

# length(findall(x->x==1,diff(N)))
# length(findall(x->x==-1,diff(N)))

println(mean(N))

rho = r / s
rho / (1 - rho)