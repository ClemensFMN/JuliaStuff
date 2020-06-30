using Plotly

# amount of coffee
c = 0.8
# temp of coffee
Tc = 100

# amount of milk
m = 0.2
# temp of milk
Tm = 20

# time constant of cooling off. this is independent of whether it's pure coffee or a milk-coffee mixture
T = 30
t = 0:0.1:100

# option A: mix milk & coffee in the beginning and let the mixture cool off
# temp of mixture
T0 = (Tc*c + Tm*m)/(c + m)
# temp of mixture varying with time: exponential decay, reaching Tm in the limit t -> infinity
tempA = Tm .+ (T0 - Tm) .* exp.(-t/T)


# option B: Let coffee cool off, then mix
tempB = Tc .* exp.(-t/T) # coffee temp varying with time. starts at Tc, goes towards 0 for t -> infinity
TBfinal = (c*tempB .+ m*Tm)./(c + m) # final temp after mixing with milk at temp Tm


trace1 = scatter(;x=t, y=tempA)
trace2 = scatter(;x=t, y=TBfinal)

plot([trace1, trace2])
