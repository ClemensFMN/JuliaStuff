

runs = int(1e6)

dist = zeros(runs)

for r in 1:runs

    x1 = rand()
    y1 = rand()

    x2 = rand()
    y2 = rand()

    dist[r] = sqrt((x2-x1)^2 + (y2-y1)^2)

end

mean(dist)