using Distributions
using DataFrames
using Gadfly

# throwing two dice N times and recording the number of consecutive dice throws
# i.e. how often do we throw a 1 followed by a 5?
N = 10

# random dice
p = DiscreteUniform(1,6)

df = DataFrame(dice1=[], dice2=[])

for i in 1:N
    # throw
    dice = rand(p,2)
    push!(df, @data([dice[1], dice[2]]))
end

# this does not work completely as the bins are not located / spaces as desired...
p = plot(df, x="dice1", y="dice2", Geom.histogram2d(xminbincount=0.5, xmaxbincount=6.5, xbincount=5, yminbincount=0.5, ymaxbincount=6.5, ybincount=5))
draw(SVG("corr_dice.svg",8inch,5inch),p)



