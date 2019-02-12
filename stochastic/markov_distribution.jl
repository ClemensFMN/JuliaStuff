include("MarkovStuff.jl")
import .MarkovStuff


P = [0.1 0.4 0.5 ;
     0.3 0.6 0.1 ;
     0.2 0.7 0.1 ]


LEN = 100_000

smpls = MarkovStuff.mc_sample_path(P, init=1, sample_size=LEN)


# number of states
N = size(P)[1]

for i=1:N
    p = length(findall(x->x==i, smpls)) / LEN
    println("probability for state $i, $p")
end

# limiting distribution
[1 0 0]*P^20

