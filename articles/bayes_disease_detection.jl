
p_pos_ill = 0.999
p_pos_healthy = 0.0001

p_ill = 0.001


p_ill_pos = p_pos_ill * p_ill / (p_pos_ill * p_ill + p_pos_healthy *(1-p_ill) )

println(p_ill_pos)


