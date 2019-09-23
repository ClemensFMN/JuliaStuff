using SimJulia
using ResumableFunctions
using Distributions
using Plots
plotly()

@resumable function client(env::Environment, name::Int, server::Resource, arr_time::Number, proc_duration::Number, waiting_time)
	@yield timeout(sim, arr_time)
    #println(name, " arriving at ", now(env))
    start = now(env)
    @yield request(server)
    # if we want the mean waiting time UNTIL service, we need to measure stop here
    #stop = now(env)
    #waiting_time[name] = stop - start
    #println(name, " starting processing at ", now(env))
    @yield timeout(sim, proc_duration)
    #println(name, " finished processing at ", now(env))
    @yield release(server)
    # this is the whole time: waiting AND processing
    stop = now(env)
    waiting_time[name] = stop - start
end


sim = Simulation()
server = Resource(sim, 1)

N = 5_000

waiting_time = zeros(N)

lambda = 0.8
mu = 5
pincoming = Exponential(1 / lambda)
#pprocess = Exponential(1 / mu)
pprocess = Uniform(0,0.1)
prev_time = 0.0

for i = 1:N
    global prev_time = prev_time + rand(pincoming) # global is required so that we define prev_time outside the for loop
    #@show prev_time
    # random processing time
    # @process client(sim, i, server, prev_time, rand(pprocess), waiting_time)
    # deterministic processing time
    @process client(sim, i, server, prev_time, 1.0, waiting_time)
end

run(sim)

# plot(waiting_time)
# histogram(waiting_time, bins=50)

println(mean(waiting_time))
#waiting time only
#println(lambda / mu / (mu - lambda))
#waiting AND processing time
println(1/(mu - lambda))
