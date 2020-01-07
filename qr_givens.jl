using LinearAlgebra

A=[1 4 6;-2 5 10;4 2 -5]
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

qr(A)
