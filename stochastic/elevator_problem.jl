# This is based on this blog
# http://varianceexplained.org/r/boarding-pass-simulation/
# but is ONLY the elevator problem (13 floors, chance that elevator stops on three consecutive ones)
# the airplane thing is further elaborated here:
# http://math.stackexchange.com/questions/5595/taking-seats-on-a-plane


N = round(Int, 1e6)

# number of buttons
M = 13
buttons = 1:M

# number of keypresses
L = 5

success = 0

for i in 1:N
    # we take a sample of the L button presses - note that we allow pressing the same button more than once
    sample = rand(buttons, L)
    #println(sample)
    # L consecutive floors -> difference between button presses (in SORTED order) is all one
    trnsfmd = diff(sort(sample))
    if(all(x->x==1, trnsfmd))
	#println(sample)
	success = success + 1
    end
end

println(success / N)
# analytical solution: the range 1..M can be partitioned into M-L+1 blocks of L numbers
# example for L=3: (1,2,3), (2,3,4)... (M-2,M-1,M)
# every block can be re-arranged in L! different ways: (1,2,3), (1,3,2). (2,1,3), (2,3,1), (3,1,2), (3,2,1)
# therefore we have (M-L+1) x L! good cases
# and in total we have L places into which we can place M different elements -> M^L cases
println(factorial(L)*(M-L+1)/M^L)
