using Combinatorics

n = 12

pis = zeros(n)


prts = partitions(n)
cnt = zeros(length(prts))

for (ind, prt) in enumerate(prts)

    # @show prt

    for i in 1:n
    	pis[i] = count(j->(j==i), prt)
    end

    num = prod( (1:n).^pis .* factorial.(convert.(Int, pis)) )
    cnt[ind] = factorial(n) / num
    @show prt, cnt[ind]

end