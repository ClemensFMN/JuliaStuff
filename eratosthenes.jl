# loosely following https://rosettacode.org/wiki/Sieve_of_Eratosthenes#Julia

function sieve(N :: Int)
  is_primes = trues(N) # allocate an array with N boolean positions
  is_primes[1] = false # one is not a prime - this is required for bootstrapping the loop below
  for i = 1:N
    if(is_primes[i] == true) # is i is a prime, we can prepare to fill all multiples with true
      # j = i*i - that's the original; but I think, we should start filling the sieve with true from position 2*i onwards...
      j = 2*i # like this
      if j > N
        return findall(is_primes) # if the first true would exceed the array, we are done and return the indices of the true's
      else
        is_primes[j:i:N] .= false # otherwise we set the sieve positions at multiples of i to false
      end
    end
  end
end


# res = sieve(100)
res = sieve(1_000_000)
println(res)
