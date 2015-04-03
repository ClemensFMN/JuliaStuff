using Winston
using Distributions


function auc(h::(Range{Float64},Array{Int64,1}))
  freq=convert(Array{Float64,1},h[2])
  e=convert(Array{Float64,1},h[1])
  numbins=length(e)
  deltax=e[2:numbins]-e[1:(numbins-1)]
  sum(deltax.*freq)
end;

N = int(1e6)


p1 = Uniform(-3,2)
samples1 = rand(p1, N)
h_samples1 = hist(samples1, 50)

p2 = Normal(-3,2)
samples2 = rand(p2, N)
h_samples2 = hist(samples2, 50)



frm = Winston.FramedPlot(title="", xlabel="x", ylabel="Density")

# Winston.add(frm, Winston.Histogram(h_samples...))
Winston.add(frm, Winston.Histogram(h_samples1[1], h_samples1[2] /auc(h_samples1), color="red"))
Winston.add(frm, Winston.Histogram(h_samples2[1], h_samples2[2] /auc(h_samples2), color="green"))

