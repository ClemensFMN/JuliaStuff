using LinearAlgebra

A=[1 4 6;-2 5 10;4 2 -5]

function getR(theta,m,i,j)
    R = Matrix(1.0I,m,m)
    R[i,i] = 0
    R[j,j] = 0
    R[j,j]= cos(theta)
    R[j,i] = sin(theta)
    R[i,j] = -sin(theta)
    R[i,i] = cos(theta)
    return R
end

# zero out A[3,1] by G(2,3,theta1)
i=2
j=3
k=1
theta = atan(- A[j,k]/A[i,k])
R1 = getR(theta,3,i,j)

A = R1*A

# zero out A[2,1] by G(1,2,theta2)
i=1
j=2
k=1 # column to zero
theta = atan(- A[j,k]/A[i,k])
R2 = getR(theta,3,i,j)

A = R2*A


# zero out A[3,2] by G(2,3,theta3)
i=2
j=3
k=2 # column to zero
theta = atan(- A[j,k]/A[i,k])
R3 = getR(theta,3,i,j)

A = R3*A



# right oder, but wrong rotations
#A=[1 4 6;-2 5 10;4 2 -5]

# zero A[3,1]
#i=1
#j=3
#k=1 # column to zero
#theta = atan(- A[j,k]/A[i,k])
#R = getR(theta,3,i,j)

#A = R*A

# zero A[2,1]
#i=1
#j=2
#k=1
#theta = atan(- A[j,k]/A[i,k])
#R = getR(theta,3,i,j)

#A = R*A

# zero A[3,2]
#i=1
#j=3
#k=2
#theta = atan(- A[j,k]/A[i,k])
#R = getR(theta,3,i,j)

#A = R*A




# qr(A)
