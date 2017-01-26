using Distributions
using Winston

function exact_prob(p,n,a)

     # calculate the exact probability of having equal or more than n*a ones in the vector
     prob = 0

     naint = convert(Int, ceil(n*a))
     for i in naint:n
         prob += binomial(n, i)*p^(i)*(1-p)^(n-i)
     end
     return(prob)
end

function ldp_bound(p,n,a)
    Ia = a*log(a/p) + (1-a)*log((1-a)/(1-p))
    return(exp(-n*Ia))
end

function markov_bound(p,n,a)
    return(p/a)
end


Npoints = 25
p = 0.5
n = 50
avec = linspace(p,1,Npoints)

#println(exact_prob(p,n,a))
#println(ldp_bound(p,n,a))
#println(markov_bound(p,n,a))

exact = zeros(Npoints)
ldp_b = zeros(Npoints)
markov_b = zeros(Npoints)

for (ind, val) in enumerate(avec)

    exact[ind] = exact_prob(p,n,val)
    ldp_b[ind] = ldp_bound(p,n,val)
    markov_b[ind] = markov_bound(p,n,val)

end


semilogy(avec, exact, "-r", avec, ldp_b, "-b", avec, markov_b, "-g")
grid()
savefig("ldp_bernoulli.png")