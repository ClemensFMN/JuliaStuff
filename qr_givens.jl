using LinearAlgebra

A=[1 4 6;-2 5 10;4 2 -5]

# order 1
phi1 = atan(-A[2,1]/A[1,1])
R1 = [cos(phi1) -sin(phi1) 0; sin(phi1) cos(phi1) 0; 0 0 1]
B = R1*A

phi2 = atan(-B[3,1]/B[1,1])
R2 = [cos(phi2) 0 -sin(phi2); 0 1 0; sin(phi2) 0 cos(phi2)]
C = R2*B

phi3 = atan(-C[3,2]/C[2,2])
R3 = [1 0 0; 0 cos(phi3) -sin(phi3); 0 sin(phi3) cos(phi3)]
R3*C


Q = (R3*R2*R1)'
R = R3*R2*R1*A


# another order of the rotations (keep in mind that the rotation angles are DIFFERENT)
# but this does NOT work
phi3 = atan(-A[3,2]/A[2,2])
R3 = [1 0 0; 0 cos(phi3) -sin(phi3); 0 sin(phi3) cos(phi3)]
B = R3*A

phi1 = atan(-B[2,1]/B[1,1])
R1 = [cos(phi1) -sin(phi1) 0; sin(phi1) cos(phi1) 0; 0 0 1]
C = R1*B

phi2 = atan(-C[3,1]/C[1,1])
R2 = [cos(phi2) 0 -sin(phi2); 0 1 0; sin(phi2) 0 cos(phi2)]
R2*C

# this is actually the "correct" order
phi2 = atan(-A[3,1]/A[1,1])
R2 = [cos(phi2) 0 -sin(phi2); 0 1 0; sin(phi2) 0 cos(phi2)]
B = R2*A

phi1 = atan(-B[2,1]/B[1,1])
R1 = [cos(phi1) -sin(phi1) 0; sin(phi1) cos(phi1) 0; 0 0 1]
C = R1*B

phi3 = atan(-C[3,2]/C[2,2])
R3 = [1 0 0; 0 cos(phi3) -sin(phi3); 0 sin(phi3) cos(phi3)]
S = R3*C

Q = (R3*R1*R2)'
R = R3*R1*R2*A


# qr(A)
