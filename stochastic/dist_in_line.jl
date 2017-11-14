# using Winston;

# distance between two random points on two lines
# each line has a length of B and the spacing between the lines is L

runs = round(Int, 1e7)

# the spacing of the lines
L = 1
# the length of the line
B = 1

dist = zeros(runs)
dist2 = zeros(runs)

for r in 1:runs
    x1 = B*rand() # pick a random point on the lower line
    x2 = B*rand() # pick a random point on the upper line
    d = (x2 - x1)^2 + L^2 # claculate the squared distance
    dist2[r] = d
    dist[r] = sqrt(d)
end

Ed = mean(dist)
Ed2 = mean(dist2)

println("mean squared distance: ", Ed2)
println("mean squared distance, analytical result: ", B^2/6 + L^2)

println("mean distance: ", Ed)
