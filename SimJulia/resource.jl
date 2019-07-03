using SimJulia
using ResumableFunctions

@resumable function car(env::Environment, name::Int, bcs::Resource, driving_time::Number, charge_duration::Number, waiting_time)
	@yield timeout(sim, driving_time)
    println(name, " arriving at ", now(env))
    start = now(env)
    @yield request(bcs)
    stop = now(env)
    waiting_time[name] = stop - start
    println(name, " starting to charge at ", now(env))
    @yield timeout(sim, charge_duration)
    println(name, " leaving the bcs at ", now(env))
    @yield release(bcs)
end


sim = Simulation()
bcs = Resource(sim, 2)


waiting_time = zeros(3)


# Car 1 coming at t=0
@process car(sim, 1, bcs, 0, 5, waiting_time)

# Car 2 coming at t=1
@process car(sim, 2, bcs, 1, 5, waiting_time)

# Car 3 coming at t=4
@process car(sim, 3, bcs, 4, 5, waiting_time)


run(sim)

println(waiting_time)
