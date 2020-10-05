using Plots
plotly()

N = 100

# part #1: plotting along p_pos_ill

p_pos_ill_vec = 1 .- 10 .^ (- range(0.5, stop=5, length=N))


p_ill = 0.1

p_pos_healthy_1 = 1e-4
res1 = p_pos_ill_vec * p_ill ./ (p_pos_ill_vec * p_ill .+ p_pos_healthy_1 *(1-p_ill) )


p_pos_healthy_2 = 1e-5
res2 = p_pos_ill_vec * p_ill ./ (p_pos_ill_vec * p_ill .+ p_pos_healthy_2 *(1-p_ill) )

p_pos_healthy_3 = 1e-6
res3 = p_pos_ill_vec * p_ill ./ (p_pos_ill_vec * p_ill .+ p_pos_healthy_3 *(1-p_ill) )


#plot(p_pos_ill_vec, res1, label="1e-4")
#plot!(p_pos_ill_vec, res2, label="1e-5")
#plot!(p_pos_ill_vec, res3, label="1e-6")


# part #2: plotting along p_pos_healthy

p_pos_healthy_vec = 10 .^ (- range(0.0, stop=3, length=N))

p_pos_ill = 0.5
res = p_pos_ill * p_ill ./ (p_pos_ill * p_ill .+ p_pos_healthy_vec *(1-p_ill) )
plot(p_pos_healthy_vec, res, label="0.5", xscale=:log10, yscale=:log10)

p_pos_ill = 0.8
res = p_pos_ill * p_ill ./ (p_pos_ill * p_ill .+ p_pos_healthy_vec *(1-p_ill) )
plot!(p_pos_healthy_vec, res, label="0.8", xscale=:log10, yscale=:log10)

p_pos_ill = 0.9
res = p_pos_ill * p_ill ./ (p_pos_ill * p_ill .+ p_pos_healthy_vec *(1-p_ill) )
plot!(p_pos_healthy_vec, res, label="0.9", xscale=:log10, yscale=:log10)

