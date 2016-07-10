using Winston;

runs = int(1e7)

dist = zeros(runs)

for r in 1:runs

    x1 = rand()

    x2 = 1 + rand()

    dist[r] = abs(x1 - x2)

end

mean(dist)
