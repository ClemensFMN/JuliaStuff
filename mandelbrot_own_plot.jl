using Winston


function mdl(c)

	z = c
	
	for n=1:10

		z = z*z + c
			if abs(z) > 25
				return n
			end
	end
	return -1
end

N = 500

c_re_vec = linspace(-2,2,N)
c_im_vec = linspace(-2,2,N)

A = zeros(N,N)

for i=1:N
	for j=1:N
		c = c_re_vec[i] + c_im_vec[j]im
		A[i,j] = mdl(c)
	end
end

imagesc(A')


