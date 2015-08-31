
# number of bits generated / string length
N = int(1e6)

p = 0.8

# entropy of X
H = -p*log2(p) - (1-p)*log2(1-p)


u = rand(N)

x = int(map(x->x>p, u))

num_ones = count(x->x==0, x)

phat = num_ones / N

Hhat = -phat*log2(phat) - (1-phat)*log2(1-phat)

println(H)
println(Hhat)
