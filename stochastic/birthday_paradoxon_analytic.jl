# birthday paradoxon extended
# We have N people in a room

using Plots

M = 365
Nvec = 5:70

# first the classical birthday problem: What's the prob, that N or more people share the same birthday 
cbp = []

for N in Nvec
    analytical_sol = 1-prod(M-N+1:big(M))/M^big(N)
    # println("analytical: ", analytical_sol)
    append!(cbp, analytical_sol)
end


# now we ask for the prob that k values are the same and the other N-k are all different
kvec = 2:4

pk = zeros(length(Nvec), length(kvec))


for (ik, k) in enumerate(kvec)

    for (iN, N) in enumerate(Nvec)
        analytical_sol = binomial(big(N),k)*M * prod(M-1:-1:M-big(N)+k) / M^big(N)
        pk[iN, ik] = analytical_sol
    end

end

# the sum of the different pk curves do not provide the cbp curve, because we miss eg two duplicates (eg [1,1,2,2,3,4,5]) 

# plot(Nvec, cbp, label="birthday paradox")

#plot!(Nvec, pk[:,1], label="k=2")
#plot!(Nvec, pk[:,2], label="k=3")
#plot!(Nvec, pk[:,3], label="k=4")
#plot!(Nvec, pk[:,4], label="k=5")
# plot!(Nvec, pk[:,8], yscale=:log10)
# savefig("2022-12-15-birthday_00.png")

dupl_2 = zeros(length(Nvec))



for (iN, N) in enumerate(Nvec)
    analytical_sol = 1/2 * binomial(big(N),2)*M * binomial(big(N-2),2)*(M-1) * prod(363:-1:big(363-N+5)) / M^big(N)
    dupl_2[iN] = analytical_sol
end

dupl_3 = zeros(length(Nvec))


for (iN, N) in enumerate(Nvec)
    analytical_sol = 1/6*binomial(big(N),2)*M * binomial(big(N-2),2)*(M-1) * binomial(big(N-4),2)*(M-2) * prod(362:-1:big(362-N+7)) / M^big(N)
    dupl_3[iN] = analytical_sol
end



plot(Nvec, cbp, label="birthday problem")
plot!(Nvec, pk[:,1], label="one duplicate")
plot!(Nvec, dupl_2, label="two duplicates")
plot!(Nvec, dupl_3, label="three duplicates")
savefig("2022-12-15-birthday_02.png")
