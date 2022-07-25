using Combinatorics

# count all permutations of N elements with n cycles of length k
# we use our trusty formula calculating the size of a permutation class
# and sum over all "fitting" perm classes (i.e. the ones with n cycles having length k)

N = 2
n = 1
k = 3

function sizePermClass(prt)

   N = sum(prt)
   pis = zeros(N)
   for i in 1:N
    	pis[i] = count(j-> j==i, prt)
   end

   num = prod( (1:N).^pis .* factorial.(convert.(Int, pis)) )
   cnt = factorial(N) / num
   return cnt   

end


global total = 0 

for prt in partitions(N)

   #@show prt

   # does the permutation include n cycles of length k?
   incld = (count(x->x==k, prt) == n)
   #@show incld

   if(incld)
      cnt = sizePermClass(prt)
       # @show prt
       #@show cnt
      global total += cnt
   end
end

@show total
