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
    stop = now(env)
    waiting_time[name] = stop - start
    #println(name, " starting processing at ", now(env))
    @yield timeout(sim, proc_duration)
    #println(name, " finished processing at ", now(env))
    @yield release(server)
end


sim = Simulation()
server = Resource(sim, 1)

N = 1000

waiting_time = zeros(N)


proc_duration = 0.5

e = Exponential(0.5)
prev_time = 0.0

for i = 1:N
    global prev_time = prev_time + rand(e) # global is required so that we define prev_time outside the for loop
    #@show prev_time
    @process client(sim, i, server, prev_time, proc_duration, waiting_time)
end

run(sim)

# plot(waiting_time)
# histogram(waiting_time, bins=50)

