using Distributions


# number of dimensions
N = 10

# distribution for "unit cube"
d = Uniform(-1.,1.)


RUNS = 100000
cnt_inside = 0

for i in 1:RUNS

  vec = rand(d, N)

  nrm = norm(vec)
  if(nrm < 1.0)
    cnt_inside += 1
  end

end

println(cnt_inside / RUNS)


Vcube = 2^N
Vsphere = pi^(N/2) / gamma(N/2+1)

println(Vsphere / Vcube)


