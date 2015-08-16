using Winston

# number of dice
N = 60
# prob of a one
pside = 1/6


kvec = 0:N
p = zeros(N+1)


for k = kvec
	# calculating the prob of a binary word length N with k ones
	p[k+1] = binomial(N,k) * pside^k * (1-pside)^(N-k)
end


# the thing peaks at pside x N
#plot(kvec, p)

#savefig("aep_dice.png")

# display works
[kvec p]

# prob of having 2 or more one's
sum(p[3:end])

Psum = zeros(N+1)

for k = 1:N
	Psum[k] = sum(p[k:end])
end

plot(Psum)
grid(true)
savefig("throwing_dice_sum.png")

