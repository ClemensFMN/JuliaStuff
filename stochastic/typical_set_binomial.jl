using Winston

# probability of a one
p = 0.2

# length of string
N = 20

# expected number of ones
println(p*N)

# entropy of X
H = -p*log2(p) - (1-p)*log2(1-p)

# typical sequences have a prob of about
p_seq = 2^(-N*H)
println(p_seq)


P = zeros(N+1)
Ptotal = zeros(N+1)

for k = 0:N

  # the prob of one string with k ones and N-k zeros
  P[k+1] = p^k * (1-p)^(N-k)

  # the probability of all strings with k ones and N-k zeros
  Ptotal[k+1] = binomial(N,k) * p^k * (1-p)^(N-k)

end

# semilogy(0:N, Ptotal)
#plot(0:N, Ptotal)

for (k, pval) in enumerate(P)
  println(k-1, "  ", pval)
end
