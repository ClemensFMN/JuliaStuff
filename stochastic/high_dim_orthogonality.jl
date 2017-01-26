using Distributions
using Winston

d = 20

RUNS = 10000
dvec = 2:100

distNorm = Normal(0,1)


res = zeros(length(dvec))

for (j, d) in enumerate(dvec)

    dotprd = zeros(RUNS)

    for i in 1:RUNS

        x1 = rand(distNorm, d)
        x1 = x1 / norm(x1)

        x2 = rand(distNorm, d)
        x2 = x2 / norm(x2)

        dotprd[i] = dot(x1, x2)
     end

     res[j] = mean(abs(dotprd))
     println(d, "....", res[j])

end

res

# semilogx(dvec, res)