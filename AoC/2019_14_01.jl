# https://adventofcode.com/2019/day/14

# let's start with the example
# 10 ORE => 10 A
# 1 ORE => 1 B
# 7 A, 1 B => 1 C
# 7 A, 1 C => 1 D
# 7 A, 1 D => 1 E
# 7 A, 1 E => 1 FUEL

# a reagent is an item & a number
struct Reagent
    number :: Int
    name :: Symbol
end

# one line is an array if input reagents producing one output reagent
struct Line
    inps :: Array{Reagent, 1}
    res :: Reagent
end


function findResLine(rls, name)
    for rl in rls
        res = rl.res
        if(res.name == name)
            return rl
        end
    end
end

# use the rule set rls to produce prod (:Symbol, Int) and update requiredStuff
# if prod cannot be produced without a waste, we only update requiredStuff
function followOneLine(rls, prod :: Tuple{Symbol, Int}, requiredStuff :: Dict{Symbol, Int})
    # find the rule which produces prod
    curRule = findResLine(rls, prod[1])

    if(mod(prod[2], curRule.res.number) == 0) # we can produce the required material without waste -> start creating it
        howOften = prod[2] / curRule.res.number # how often do we need to apply the rule to generate the required ouput
        @show curRule
        for inp in curRule.inps # now go over all inputs
            #@show inp
            cur = get(requiredStuff, inp.name, 0)
            if(cur == 0) # not required so far
                requiredStuff[inp.name] = howOften * inp.number
            else # has already been required - update amount
                requiredStuff[inp.name] += howOften * inp.number
            end
        end
        delete!(requiredStuff, prod[1]) # delete the originally required item
    else # we cannot produce witohut a waste -> do not produce and update requiredStuff right away
        cur = get(requiredStuff, prod[1], 0)
        if(cur == 0) # not required so far
            requiredStuff[prod[1]] = prod[2]
        else # has already been required - update amount
            requiredStuff[prod[1]] += prod[2]
        end
    end
    requiredStuff
end

# use the rule set rls to produce prod (:Symbol, Int) and update requiredStuff
# we produce with a waste
function followOneLineWithWaste(rls, prod :: Tuple{Symbol, Int}, requiredStuff :: Dict{Symbol, Int})
    # find the rule which produces prod
    curRule = findResLine(rls, prod[1])
    howOften = ceil(prod[2] / curRule.res.number) # how often do we need to apply the rule to generate the required ouput
    for inp in curRule.inps # now go over all inputs
        #@show inp
        cur = get(requiredStuff, inp.name, 0)
        if(cur == 0) # not required so far
            requiredStuff[inp.name] = howOften * inp.number
        else # has already been required - update amount
            requiredStuff[inp.name] += howOften * inp.number
        end
    end
    delete!(requiredStuff, prod[1]) # delete the originally required item
end


function soFar(all_Rules)
    res = followOneLine(all_Rules, (:FUEL, 1), Dict{Symbol, Int}())
    res = followOneLine(all_Rules, (:E, 1), res)
    res = followOneLine(all_Rules, (:D, 1), res)
    res = followOneLine(all_Rules, (:C, 1), res)
    res = followOneLine(all_Rules, (:B, 1), res)
    res = followOneLineWithWaste(all_Rules, (:A, 28), res)
    @show res
end


# 7A, 1E => 1 FUEL becomes then the following line TODO: parsing
l6 = Line([Reagent(7, :A), Reagent(1, :E)], Reagent(1, :FUEL))

l1 = Line([Reagent(10, :ORE)], Reagent(10, :A))
l2 = Line([Reagent(1, :ORE)], Reagent(1, :B))
l3 = Line([Reagent(7, :A), Reagent(1, :B)], Reagent(1, :C))
l4 = Line([Reagent(7, :A), Reagent(1, :C)], Reagent(1, :D))
l5 = Line([Reagent(7, :A), Reagent(1, :D)], Reagent(1, :E))

all_Rules = [l1, l2, l3, l4, l5, l6]

#startHere = findFuelLine(all_Rules)
#findResLine(all_Rules, :A)

# res = followOneLine(all_Rules, (:FUEL, 1), Dict{Symbol, Int}())
#Dict{Symbol,Int64} with 2 entries:
#  :A => 7
#  :E => 1

# followOneLine(all_Rules, (:A, 7), Dict{Symbol, Int}())
# Dict{Symbol,Int64} with 1 entry:
#   :A => 7

# followOneLineWithWaste(all_Rules, (:A, 7), Dict{Symbol, Int}())
#Dict{Symbol,Int64} with 1 entry:
#  :ORE => 10

# STATUS
# The first example is solved manually in the function soFar() above.
# So far so good, but there are case, with several options to produce something with 
# waste and no more options to produce something without waste.
# a simple exmaple is given below
#1 ORE => 4A
#3 ORE => 2B
#2A, 3B => 7D
#1A, 3D => 1FUEL

# both 1A & 3D in the last line can only be produced with waste. Inth efollowing we list the 
# content of the requiredStuff map
# option 1 (starting with 1A)
# 1A, 3D
# 1 ORE, 3D - create 4As from the 1 ORE
# 1 ORE, 2A, 3B - create 3Ds from 2A & 3B
# 1 + 1 + 6 = 8 ORE - create 2As and 3Bs from ORE

# option 2 (starting with 3D)
# 1A, 3D
# 1+2 = 3A, 3B # create 3Ds from 2A & 3B
# 3A, 6 ORE # create 3Bs from 6 ORE
# 1 + 6 = 7 ORE # create 3As from 1 ORE
