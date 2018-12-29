# simulate a poisson process
# we simulate N points with exponentially distributed interarrival times
# the cumulative sum yields the arrival times

using Distributions



RUNS = 1_000_000

N = 15
r = 1.5 #careful: r is the scale parameter!!

pdf_exp = Exponential(r)



num_points = Array{Float64}(undef, RUNS)
window = 5.0

for (r,_) in enumerate(1:RUNS)

    # interarrival times have exponential distribution
    interarrivals = rand(pdf_exp, N)

    # the arrival times are the sum of the interarrival times
    arrivals = cumsum(interarrivals, dims=1)

    # count the number of events in a window
    # the window must be smaller than the maximum arrival time,
    # otherwise we do not have sufficiently many events to count...
    # let's leave this out for the moment - in addition, when we want to count X events (probs section at the end), we must choose N accordingly...
    num_points[r] = length(findall(x->x < window, arrivals))

end

num_points

# means
println("simulation: ", mean(num_points))
println("analytical result: ", window / r)

# probs

for k = 1:10
    println(k)
    println( (window/r)^k * exp(-window/r)/factorial(k) )
    println( length(findall(x->x==k, num_points))/RUNS )
end
