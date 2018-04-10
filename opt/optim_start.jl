using Optim

f(x) = (x[1] - 2).^2 + (x[2] + 0.5).^2

res = optimize(f, [0.0, 0.0])
println(res)
