using DynamicalSystems, Plots


u0 = [10.0,10,10]
lo = Systems.lorenz(u0)


res = zeros(3, 1501)

for i in 1:3
    u = u0 .+ i*1e-3
    tr = trajectory(lo, 15, u)
    res[i,:] = tr[:,1]
end

plot(res[1, :])
plot!(res[2, :])
plot!(res[3, :])
