using Gadfly
using Distributions
using DataFrames

# throwing two dice N times and recording the number of consecutive dice throws
# i.e. how often do we throw a 1 followed by a 5?
N = 100000

# random dice
p = DiscreteUniform(1,6)

# this is the dict to hold the dice frequencies (i.e. (first, second throw) -> frequency)
d = Dict()

for i in 1:N
    # throw
    dice = rand(p,2)
    # println(dice)
    # get the existing count; if this has not been thrown before, set to 0
    old_count = get!(d, dice, 0)
    # and update the count by one...
    d[dice] += 1
end

# println(d)

# we use Geom.rectbin for plotting which expects a dataframe with three columns: x, y, and z
# we need to bring the data into this form -> rather cumbersome  
inval = zeros(36,2)
outval = zeros(36)

c = 1

for i in 1:6
    for j in 1:6
        inval[c,1] = i
        inval[c,2] = j
        outval[c] = d[[i,j]]
        c += 1
    end
end

# create the dataframe out of these vectors
df = DataFrame(dice1=inval[:,1], dice2=inval[:,2], count=outval)

p = plot(df, x=:dice1, y=:dice2, color=:count, Geom.rectbin)

draw(SVG("corr_dice.svg",8inch,5inch),p)

