# Numbers
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
  def coprime? n 
    min = (self > n) ? n : self
    (2..min).each do |x|
      return false if (self % x == 0 and n % x == 0)
    end
    return true
  end
end
# Array
class Array
  def vcount
    count = {}
    self.each do |item| 
      if !count.has_key?(item)
        count[item] = 1
      else
        count[item] += 1
      end
    end
    return count
  end
  def sum; self.reduce(:+); end
  def mean; sum / size; end
  def f_mean; sum.to_f / size; end
  def mode
    self.vcount.each.collect { 
      |k, v| k if v == self.vcount.each_value.to_a.max }.compact[0]
  end
  def has?(item); !!self.index(item); end
  def uniq?; length == uniq.length; end
  def permutations
    return [self] if size < 2
    perm = []
    each { |e| (self - [e]).permutations.each { |p| perm << ([e] + p) } }
    perm
  end
  def permute(prefixed=[])
    if (length < 2)
      # there are no elements left to permute
      yield(prefixed + self)
    else
      # recursively permute the remaining elements
      each_with_index do |e, i|
        (self[0,i]+self[(i+1)..-1]).permute(prefixed+[e]) { 
          |a| yield a }
      end
    end
  end
end
# String
class String
  def to_hr; self; end
  def palindrome?
    return false if self[0] == "0"
    self == self.reverse
  end
end
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
# Helpers
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
