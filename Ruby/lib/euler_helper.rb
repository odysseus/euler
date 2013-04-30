def exec n
	svdir = Dir::pwd
	cd "#{`echo $HOME`.strip}/Desktop"
	f = open("rbeuler_exec.txt", "w")
	(1..n).each do |i|
		f.write("puts \"Project Euler Problem #{i}:      \#{eu#{i}.to_hr}\"\n")
	end
	f.close
	cd svdir
end
def ln; puts ""; end
def cd path
	Dir.chdir(path)
end
def pytrips m, n, k
  def findtrips m, n, k
    if ((m-n).odd? and m.coprime?(n))
      a = k * (m**2 - n**2)
      b = k * (2*m*n)
      c = k * (m**2 + n**2)
    else
      a, b, c = 0, 0, 0
    end
    return [a, b, c]
  end
  if m == n
    return [0, 0, 0]
  elsif m > n
    return findtrips(m, n, k)
  else
    return findtrips(n, m, k)
  end
end
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
