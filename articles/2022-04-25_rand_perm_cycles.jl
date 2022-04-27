using Permutations
# using Plots

# play around with the package
# either create a permutation from an array
#a = [4,1,3,2,6,5];
#p = Permutation(a)
# or a random permutation
#p = RandomPermutation(6)
#@show p
#@show cycles(p)

# we generate random permutations of N elements
# for each, we obtain the cycle structure

N = 100
RUNS = 100_000
cnt = zeros(RUNS)

for run in 1:RUNS
    p = RandomPermutation(N)
    clen = length.(cycles(p))

    cnt[run] = count(i->i==1, clen) # count the number of fixed points (cycles of length 1)
end


# histogram(cnt)
# for N -> \infty, the pmf of having k fixed points is 1/(e k!) (https://math.ucr.edu/home/baez/permutations/permutations_1.html)

for k=0:8
    ms = count(i->i==k, cnt) / RUNS
    an = 1/(exp(1) * factorial(k))
    @show ms, an
end
    
    

