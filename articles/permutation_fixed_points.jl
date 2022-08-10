using Permutations

# create all permutations of length N
# count the number of perms with given number of fixed points -> store in hist
# these are the Recontres Numbers (2016-01-04)

N = 5

cnt = zeros(factorial(N))

for iter = 1:factorial(N)
    p = Permutation(N,iter)
    fps = fixed_points(p)
    cnt[iter] = length(fps)
end

hist = zeros(N+1)

for iter = 0:N
    hist[iter+1] = count(x -> x==iter, cnt)
end

hist
