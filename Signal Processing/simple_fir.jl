using DSP

a = [1.]
b = [1., 2.]

x = [1., 0, 0, 0]

y =filt(b, a, x)

print(y)


