

runs = int(1e6)
dim = 10
dist = zeros(runs)

for r in 1:runs

    p1 = rand(dim)
    p2 = rand(dim)

    dist[r] = norm(p1-p2)

end

mean(dist)