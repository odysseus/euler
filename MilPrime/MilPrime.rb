def fast_prime limit
  def is_prime? n
    return false if n == 1
    return true if n < 4
    return false if n % 2 == 0
    return true if n < 9
    return false if n % 3 == 0
    r = Math.sqrt(n).to_i
    f = 5
    while f <= r
      return false if n % f == 0
      return false if n % (f + 2) == 0
      f += 6
    end
    return true
  end
  primes = 1
  candidate = 1
  
  while primes < limit
    candidate += 2
    if is_prime?(candidate)
      primes += 1
    end
  end
  return candidate
end

puts fast_prime 1_000_000