from math import sqrt

def fast_prime(limit):
    """Possibly due to the overhead of iterating a list, this method is much 
	much faster at finding primes than the list methods I've been using before"""
	# Millionth Prime in 216.03 seconds
    def isPrime(n):
        if (n == 1): return False
        elif (n < 4): return True
        elif (n % 2 == 0): return False
        elif (n < 9): return True
        elif (n % 3 == 0): return False
        else:
            r = int(sqrt(n))
            f = 5
            while (f <= r):
                if (n % f == 0): return False
                if (n % (f + 2) == 0): return False
                f += 6
        return True
    primes = 1
    candidate = 1
    while (primes < limit):
        candidate += 2
        if (isPrime(candidate)):
            primes += 1
    return candidate

print fast_prime(1000000)
