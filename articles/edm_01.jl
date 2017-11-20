
function EDMCalc(X)
    return ones(N,1)*diag(X'*X)' - 2*X'*X + diag(X'*X)*ones(1,N)
end



d = 2
N = 4

# the point matrix
X = [0 1 0 2;
     0 0 1 3]


edm = EDMCalc(X)
println(edm)


# the edm reconstruction with one point at zero
d1 = edm[:,1]
G = -1/2*(edm - ones(N,1)*d1' - d1*ones(1,N))

# the alternative with geometric centering of the matrix
#J = eye(N) - 1/N*ones(N,1)*ones(1,N)
#G = -1/2*J*edm*J

d, u = eig(G)

dtrunc = [0;0;d[3:4]]
Xhat = diagm(sqrt.(dtrunc))*u'

using Plots
plotly()

scatter(X[1,:], X[2,:])
# it seems as if the whole procedure returns a rotated solution
scatter!(Xhat[3,:], Xhat[4,:])
# this is not a problem, as the distance differences are the same as for X
println(EDMCalc(Xhat))

# we can rotate the result (Xhat)
# phi = -0.58 # found out via trial and error
# other option: the second column (second point) of X = [1 0]^T; Taking R [1 0]^T = [cos(\phi) sin(\phi)]^T
# so we can obtain \phi by taking the acos from the appropriate location in Xhat
phi = -acos(Xhat[3,2])
# rotation matrix
R = [cos(phi) -sin(phi); sin(phi) cos(phi)]

# rotate the result
Xhatrot = R * Xhat[3:4,:]
println(Xhatrot)
# and plot it
scatter!(Xhatrot[1,:], Xhatrot[2,:])


