using Polynomials

# Rectangular window of length N.
function rect(n::Integer)
    ones(n)
end


# Hanning window of length N.
function hanning(n::Integer)
    [0.5*(1 - cos(2*pi*k/(n-1))) for k=0:(n-1)]
end

# Hamming window of length N.
function hamming(n::Integer)
    [0.54 - 0.46*cos(2*pi*k/(n-1)) for k=0:(n-1)]
end


# "exact" blackman window, alpha=0.16
function blackman(n::Integer)
    a0, a1, a2 = 0.42, 0.5, 0.08
    t = 2*pi/(n-1)
    [a0 - a1*cos(t*k) + a2*cos(t*k*2) for k=0:(n-1)]
end

# frequency response of a discrete-time system, evaluated on theta=[0,pi]
function freqz(b, a)
	w = linspace(0,pi,512)
	ejw = exp(-im * w)
	w, polyval(Poly(b), ejw) ./ polyval(Poly(a), ejw)
end

