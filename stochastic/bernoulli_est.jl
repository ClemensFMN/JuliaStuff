# we have a biased coin with head (H) and tail (T)
# the probability for head is P(H) = p, for tail is P(T) = 1-p -> that's the model
# 
# we observe a sequence of H heads and T tails (in total we throw the coin N = H+T times
# and want to estimate p
# P(model | observation) \propto P(observation | model) P(model)
# assuming a uniform prior, we have
# P(model | observation) \propto P(observation | model)
# and P(observation | model) = (H+T \over H) p^h (1-p)^T

using Gadfly
using DataFrames

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
    

df1 = DataFrame(pvec=pvec, P=ps[1,:], label="(H)")
df2 = DataFrame(pvec=pvec, P=ps[2,:], label="(HH)")
df3 = DataFrame(pvec=pvec, P=ps[3,:], label="(HHT)")
df4 = DataFrame(pvec=pvec, P=ps[4,:], label="(HHTT)")
df5 = DataFrame(pvec=pvec, P=ps[5,:], label="(20xH, 20xT)")

df = vcat(df1, df2, df3, df4, df5)

p = plot(df, x=:pvec,y=:P, color=:label, Geom.line)

draw(SVG("bernoulli_est.svg",7inch,5inch),p)
draw(PS("bernoulli_est.eps",7inch,5inch),p)
