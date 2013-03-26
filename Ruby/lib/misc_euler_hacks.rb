#!/opt/local/bin/ruby1.9

# A variety of helper methods from Project Euler
# This file contains a number of methods that did not make it into the 
# final euler.rb script or into the related extlib.rb import because they
# were deemed to narrowly focused or of uncertain utility, but could become
# more useful in the future
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
  def runningtotal(topslice)
    top = self[0,topslice]
    tots = []
    top.each_index do |i|
      top[0..i].each {|x| tots.push(top[i]+x)}
    end
  end
  def lsdiff 
    self.each_index.collect{|i| self[i+1]-self[i] if 
      self[i+1]!=nil}.compact
  end
  def uniqlsdiff; self.lsdiff.uniq; end
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

class Integer
  # Adding a prime checking method directly to Fixnum
  def prime?
    n = self
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
  def _!; (2..self).reduce(:*); end
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
  def _!; return 1 if self==1; (2..self).reduce(:*); end
  def length; to_s.length; end
  def to_a; to_s.split(//).map {|i| i.to_i }; end
  def to_s_a; to_s.split(//); end
  def to_a_s; to_a.to_s; end
  def to_hr
    # Returns human readable formatted string
    # eg. 1000000 becomes 1,000,000
    commas = length/3
    commas -= 1 if length%3 == 0
    return to_s if commas == 0
    strarray = to_s_a
    commas.downto(1) do |x|
      strarray[(x * -3), 0] = ","
    end
    return strarray.join("")
  end
  # calculates the binomial coefficient of self choose k
  def choose k
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
end

def findpermno(series, permno)
  # Takes an ordered series as the first argument
  # and a permutation number as the second argument
  # and finds that permutation for the given series
  # even works with non numeric series'
  if permno > series.length._!
    puts "Impossible, only #{series.length._!.to_hr} permutations possible."
    return false
  end
  facts = []
  (series.length-1).downto(1) do |x|
    facts.push(x._!)
  end
  ans = []
  final = []
  total, totsave, f, i = 0, 0, 0, 1
  loop do
    i = 0
    loop do
      total = totsave
      total += i * facts[f]
      if total == permno
        ans.push(i-1)
        break
      elsif total >= permno
        total = totsave + ( (i-1) * facts[f] )
        totsave = total
        ans.push(i-1)
        f += 1
        break
      else
        i += 1
      end
    end
    break if total == permno
  end
  test = ans.each_index.collect { |x| 
    ans[x] * facts[x] }.compact.reduce(:+)
  ans.each do |serial|
    final.push(series[serial])
    series -= final
  end
  final += series.permutations[(permno - test) - 1]
  return final
end

# Unused helper method for problem 30, converted to a lambda Fn
# instead (lambda example is below)
def iscorrect(n, p)
  n == n.to_a.map {|i| i**p}.reduce(:+)
end
y = lambda { |n| n == n.to_a.map {|i| i**4}.reduce(:+) }
# Partially evaluated
x = lambda { |n| y.call(n, 4) }


if __FILE__ == $0
  
  puts findpermno(('a'..'z').to_a, 10_000_000).join("")
  
  
  
  
end
  
