# we consider a game player vs bank 

# the player starts with a certain start amount c_0 the game consists of
# several rounds; in every round, the player can win or lose 1 with prob 1/2.
# when the player wins, his capital is increased by 1; in case of losing, the
# players capital is decresed by 1. When the player's capital becomes zero,
# the game stops. whent he player's capital exceeds a certain threshold C^*,
# the game stops as well.

# this scenario can be modeled by means of an absorbing markov chain, where
# the states represent the players capital; e.g. state 4 represents the player
# with capital 4. state 0 & c_* are absorbing states, since in these cases the
# game ends. transition probs between non-absorbing states are 0.5; e.g.
# P(s_n=5|s_n-1=4) = 1/2.
# P(s_n=0|s_n-1=0) = 1, P(s_n=c_*|s_n-1=c_*) = 1

# c_0 = 5
c_star = 9
# number of transient states
t = c_star-2

Ptotal = zeros(c_star, c_star)

# build up the transitions between all states except
Ptotal[1:t,1:t] = diagm(0.5*ones(c_star-3),1) + diagm(0.5*ones(c_star-3),-1)

# the c=0 state
Ptotal[c_star-1, c_star-1] = 1
# the c=c^* state
Ptotal[c_star, c_star] = 1

Ptotal[1,c_star-1] = 0.5
Ptotal[c_star-2, c_star] = 0.5

# now take the matrix apart
Q = Ptotal[1:t,1:t]
R = Ptotal[1:t, c_star-1:c_star]

# the fundamental matrix N
# n_ij ... the number of states the MC is in state j
# when started in state i
N = inv(eye(t) - Q)

# t_i ... expected number of steps till absorption when started in t_i
t = N*ones(t)

# absorption probability B
# b_ij ... prob, that start state i will be absorbed in state j
B = N*R

