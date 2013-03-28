class Integer
	def prime?
		# Adding a prime checking method directly to Fixnum
		# Much, much faster than the 'mathn' library generator
		n = self
		return false if n < 0
		return false if n == 1
		return true if n < 4
		return false if n % 2 == 0
		return true if n < 9
		return false if n % 3 == 0
		r = Math::sqrt(n).to_i
		f = 5
		while f <= r
			return false if n % f == 0
			return false if n % (f + 2) == 0
			f += 6
		end
		return true
	end
	def sumdiv
		total = 0
		(1..((self**0.5).to_i)).each do |i|
			if self % i == 0
				total += i
				total += self/i
			end
		end
		total -= (self**0.5).to_i if (self**0.5).to_i**2 == self
		return (total-self)
	end
	def abundant?; self.sumdiv > self; end
	def deficient?; self.sumdiv < self; end
	def perfect?; self.sumdiv == self; end
	def length; to_s.length; end
	def to_a; to_s.split(//).map {|i| i.to_i }; end
	def to_strarr; to_s.split(//); end
	def _!
		return 1 if self == 0
		x, t = self, 1
		while (x >= 1)
			t *= x
			x -= 1
		end
		t
	end
	def sum_of_digit_factorials
		facts = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]
		to_a.inject(0) { |x, y| x += facts[y] }
	end
	def primefacts
		# Empty while loop is more efficient, allowing n to reset
		# each time a new factor is found
		n = self
		x = 3
		facts = []
		facts.push(2) if n.even?
		while n.even?
			n /= 2
		end
		while true && n > 1
			t = false
			(x..n).step(2) do |i|
				if n == i
					facts.push(i)
					return facts
				elsif n % i == 0 and i.prime?
					facts.push(i)
					n /= i
					x, t = i, true
				end
				break if t
			end
		end
		n
	end
	def to_hr
		# Returns human readable formatted string
		# eg. 1000000 becomes 1,000,000
		commas = length/3
		return to_s if commas == 0
		commas -= 1 if length%3 == 0
		strarray = to_strarr
		commas.downto(1) do |x|
			strarray[(x * -3), 0] = ","
		end
		return strarray.join("")
	end
	def choose k
		# calculates the binomial coefficient of self choose k
		return 0 if (k > self)
		n = self
		r = 1
		1.upto(k) do |d|
			r *= n
			r /= d
			n -= 1
		end
		return r
	end
	def circulate_each
		s = self
		length.times do
			yield s
			s = s.to_s.split(//)
			*h, t = s
			s = h.unshift(t).join('').to_i
		end
	end
	def circular_prime?
		return false unless prime?
		circulate_each { |x| return false unless x.prime? }
		true
	end
	def palindrome?
		to_s.palindrome?
	end
	def to_bin
		str = []
		n = self
		while n > 0
			str.push((n%2).to_s)
			n /= 2
		end
		return (str.join.reverse.to_i)
	end
	def pandigital19?
		require 'set'
		onenine = 123456789.to_a.to_set
		nset = self.to_a.to_set
		return (nset.length == 9 and self.length == 9 and nset == onenine)
	end
end
