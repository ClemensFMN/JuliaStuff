using SimJulia
using ResumableFunctions

@resumable function car(sim::Simulation)
    while true
        println("Starting parking at $(now(sim))")
        @yield timeout(sim, 10)
        println("Start driving at $(now(sim))")
        @yield timeout(sim, 10)
    end
end


sim = Simulation()
@process car(sim)
println(sim)
run(sim, 100)


