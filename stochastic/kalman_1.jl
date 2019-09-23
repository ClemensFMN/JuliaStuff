using Distributions
using Plots
plotly()

N = 100
Q = [0.1 0 ; 0 0.001]

wdist = MvNormal(zeros(2), Q)
A = [1 1 ; 0 1]
xtrue = zeros(2,N)

sv2 = 0.01
vdist = Normal(0, sqrt(sv2))
R = [sv2]
G = [1 0]
y = zeros(1, N)


priorx = MvNormal(zeros(2), I)
xtrue[:,1] = rand(priorx, 1)
xtrue[2,1] = 1

y[:,1] = G*xtrue[:,1] + rand(vdist,1)

for tme = 2:N
	if(tme < 25)
		xtrue[2,tme] = 1
	else
		xtrue[2,tme] = 5
	end

	xtrue[:,tme] = A*xtrue[:,tme-1] + rand(wdist, 1)

	if(tme < 25)
		xtrue[2,tme] = 1
	else
		xtrue[2,tme] = 5
	end


	y[:,tme] = G*xtrue[:,tme] + rand(vdist,1)
end


xf = zeros(2,N)
sigmaf = zeros(2,2,N)

xp = zeros(2,N+1)
xp[:,1] = [0;0]
sigmap = zeros(2,2,N+1)
sigmap[:,:,1] = [1 0 ; 0 1]



for tme = 1:N
	# @show tme
	xf[:,tme] = xp[:,tme] + sigmap[:,:,tme]*G'*inv(G*sigmap[:,:,tme]*G'+R)*([y[tme]] - G*xp[:,tme])
	sigmaf[:,:,tme] = sigmap[:,:,tme] - sigmap[:,:,tme] * G'*inv(G*sigmap[:,:,tme]*G'+R) * G*sigmap[:,:,tme]

	xp[:,tme+1] = A*xf[:,tme]
	sigmap[:,:,tme+1] = A*sigmaf[:,:,tme]*A' + Q

	# @show xp[:,tme+1]
	# @show sigmap[:,:,tme+1]
end

ind = 1
plot(1:N, xf[ind,:])
plot!(1:N, xtrue[ind,:])

