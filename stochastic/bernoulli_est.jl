# we have a biased coin with head (H) and tail (T)
# the probability for head is P(H) = p, for tail is P(T) = 1-p -> that's the model
# 
# we observe a sequence of H heads and T tails (in total we throw the coin N = H+T times
# and want to estimate p
# P(model | observation) \propto P(observation | model) P(model)
# assuming a uniform prior, we have
# P(model | observation) \propto P(observation | model)
# and P(observation | model) = (H+T \over H) p^h (1-p)^T

using Winston

pvec = linspace(0,1,100)

# observation array - every column corresponds to an observation
# the first row is the number of heads, the second the number of tails
all_obs = [1 2 2 2 20;
           0 0 1 2 20]

(nix, nobs) = size(all_obs)

ps = zeros(nobs, length(pvec))

for ind_o = 1:nobs
    
    obs = all_obs[:,ind_o]

    N = sum(obs)
    H = obs[1]
    T = obs[2]

    for (ind_p,p) in enumerate(pvec)
        ps[ind_o, ind_p] = binomial(N,H)*p^H*(1-p)^T
    end

end

ps = ps ./ sum(ps,2)
    
#p = FramedPlot()
#c = Curve(pvec, ps[2,:],color="red")#, symbolkind="circle")
#setattr(c,label="(HH)")
#style(c,symbolkind="circle")
#add(p,c)

plot(pvec, ps[1,:],"-r", pvec, ps[2,:],"-g", pvec, ps[3,:],"-y", pvec, ps[4,:],"-k", pvec, ps[5,:],"-k:")
legend(["(H)","(HH)","HHT","HHTT", "20H, 20T"])
grid()
savefig("bernoulli_est.png")
