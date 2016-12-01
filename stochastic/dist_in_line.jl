# using Winston;

runs = round(Int, 1e7)

L = 2

dist = zeros(runs)
dist_sq = zeros(runs)

for r in 1:runs

    x1 = rand()
    x2 = L + rand()
    dist[r] = x2 - x1
    dist_sq[r] = (x2 - x1)^2

end

Ed = mean(dist)
Ed2 = mean(dist_sq)

println(Ed)
println(Ed^2)
println(Ed2)
# For fixed x1 (equal 0), the difference is independent of L! It is 1/12
println(Ed2 - Ed^2)