def fast_prime limit
	return 2 if limit == 1
	def is_prime? n
		return false if n == 1
		return true if n < 4
		return false if n % 2 == 0
		return true if n < 9
		return false if n % 3 == 0
		r = (n ** 0.5).to_i
		(5..r).step(6) do |f|
			return false if n % f == 0
			return false if n % (f + 2) == 0
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
