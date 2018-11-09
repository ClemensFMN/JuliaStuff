# agent-based modeling - simple economy
# we have agents which exchange a fixed amount of money
# the money is constant in the system
using Plots
plotly()


N = 100 # number of agents


RUNS = 2
exchanges = 100 # exchanges between agents
# store the wealth
wealth_final = zeros(exchanges, RUNS, N)

wealth = 50*ones(N) # inital wealther distribution: every agent has 50


for r in 1:RUNS
	for e in 1:exchanges
		# choose 2 random agents - note that these could be the same two agents; i.e. no exchange is taking place
		# as a consequence, we will (most likely), have less than exchanges than the variable exchanges says...
		a1, a2 = rand(1:N, 2)
		total = wealth[a1] + wealth[a2] # determine the total wealth of the 2 agents
		splt = rand()
		wealth[a1] = splt * total # and split the 2 agent's sum wealth randomly between them
		wealth[a2] = (1-splt) * total

		if(mod(e,10) == 0)
			global wealth_final[e, r, :] = wealth
			println(r, "...", e)
		end
	end
end

# combine wealth of all agents from all RUNS after specific number of exchanges
vis = reshape(wealth_final[10,:,:],N*RUNS,1)
histogram(vis, nbins=50)
