# agent-based modeling - simple economy
# we have agents which exchange a fixed amount of money
# the money is constant in the system
using Plots
plotly()

N = 10 # number of agents


RUNS = 1000
exchanges = 10_000 # exchanges between agents
wealth_final = []

wealth = 50*ones(N) # inital wealther distribution: every agent has 50


for r in 1:RUNS
	for e in 1:exchanges

		for agent=1:N
			# construct an array of all other agents
			rand_range = [collect(1:agent-1); collect(agent+1:N)]
			# println(agent, rand_range)
			# the other agent to exchange money with
			other_agent = rand(rand_range)
			# exchange money with other agent (if own wealth > 1)
			if(wealth[agent] > 1)
				wealth[agent] = wealth[agent] - 1 # decrease own wealth
				# println(agent, "  ", other_agent)
				wealth[other_agent] = wealth[other_agent] + 1 # and increase the other agent's wealth
			end
		end
	end
	global wealth_final = [wealth_final; wealth]
	println(r)
end

histogram(wealth_final, nbins=30)


