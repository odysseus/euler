##============================================================================
## Name        : euler.rb
## Author      : Ryan Case
## Version     : λ
## Description : Project Euler Problems - In Ruby
##============================================================================

require './lib/euler_string'
require './lib/euler_array'
require './lib/euler_integer'
require './lib/euler_helper'
require './lib/fast_prime'

def eu1
  # Problem 1: 
  # Find the sum of all natural numbers below 1000 that are 
  # divisible by 3 or 5
  return (1...1000).collect{ |i| i if i % 3 == 0 or i % 5 == 0 }.compact!.reduce(:+)
end

def eu2
  # Problem 2: 
  # Find the sum of all even numbers in the Fibonacci sequence that
  # are smaller than 4 million
  # Answer: 4,613,732
  total = 0
  a, b = 0, 1
  while b < 4000000
    total += b if b.even?
    a, b = b, a+b
  end
  return total
end

def eu3
  # Problem 3: 
  # Find the largest prime factor of the number 600,851,475,143
  # Answer: 6857
  n = 600_851_475_143
  x = 3
  while n.even?
    n /= 2
  end
  while true
    t = false
    x.step(n, 2) do |i|
      return n if n == i
      if n % i == 0 and i.prime?
        n /= i
        x, t = i, true
      end
      break if t
    end
  end
end

def eu4
  # Find the largest palindrome made from 2 3-digit numbers
  # Answer: 906609
  largest = 0
  (100..999).each do |a|
    (100..999).each do |b|
      rs = (a * b).to_s
      largest = rs if rs == rs.reverse and rs.to_i > largest.to_i
    end
  end
  return largest
end

def eu5
  # What is the smallest positive number that is evenly divisible by 
  # all of the numbers from 1 to 20
  # Answer: 232,792,560
  test = 20
  done = false
  while !done
    scan = 2
    while test % scan == 0
      scan += 1 if scan < 21
      if scan == 21
        done = true
        return test
      end
    end
    test += 20
  end
  return test
end
    
def eu6
  # Find the difference between the sum of squares for the first 
  # 100 natural numbers and the square of sums
  # Answer: 25,164,150
  squaresums = 0
  sumsquares = 0
  (1..100).each {|x| squaresums += x}
  squaresums = squaresums ** 2
  (1..100).each {|x| sumsquares += x ** 2}
  return squaresums - sumsquares
end

def eu7
  # Question: Find the 10,001st prime number
  # Answer: 104,743
  def primeGen n
    num = 5
    count = 3
    while count < n
      num += 2
      if num.prime?
        count += 1
      end
    end
    return num
  end
  return primeGen(10001)
end

def eu8
  # Question: Find the greatest product of five consecutive digits in this
  # 1000 digit number
  # Answer: 40,824
  bignum = 7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450
  numarray = bignum.to_s.split(//).map{|i| i.to_i}
  result = 0
  a, b = 0, 4
  while b < 1000
    total = 1
    (a..b).each {|i| total *= numarray[i]}
    result = total if total > result
    a, b = a+1, b+1
  end
  return result
end

def eu9
  # Problem 9:
  # There exists exactly one Pythagorean triplet where
  # a+b+c = 1000, find the product a * b * c
  # Answer: 31,875,000
  (1..25).each do |x|
    (1..25).each do |y|
      (1..25).each do |k|
        trips = pytrips(x, y, k)
        if trips.inject(:+) == 1000
          return trips[0] * trips[1] * trips[2]
        end
      end
    end
  end
end

def eu10
  # Problem 10: 
  # Find the sum of all primes below two million
  # Answer: 142,913,828,922
  total = 17
  n = 11
  while n < 2000000
    total += n if n.prime?
    total += (n+2) if (n+2).prime?
    n += 6
  end
  return total
end  

def eu11
  # Problem 11:
  # Find the largest product of 4 numbers in this 20x20 grid
  # (file in eu11.txt) [up-down, left-right, diagonal]
  # Answer: 70,600,674
  dat = []
  open("files/eu11.txt", "r") do |file|
    file.each { |line| dat.push(line) }
  end
  dat.each_index { |i| dat[i] = dat[i].split(' ')}

  dat.each do |row|
    row.each_index { |i| row[i] = row[i].to_i }
  end
  max = 0
  dat.each do |row|
    row.each_index do |i|
      max = row[i,4].reduce(:*) if row[i,4].reduce(:*) > max
    end
  end
  (0...(dat.length-4)).each do |i|
    (0...20).each do |x|
      arr = []
      (0...4).each do |y|
        arr.push(dat[i+y][x])
      end
      max = arr.reduce(:*) if arr.reduce(:*) > max
    end
  end
  (0...(dat.length-3)).each do |i|
    (0...17).each do |x|
      arr = []
      (0...4).each do |y|
        arr.push(dat[i+y][x+y])
      end
      max = arr.reduce(:*) if arr.reduce(:*) > max
    end
  end
  (0...(dat.length-3)).each do |i|
    (3...20).each do |x|
      arr = []
      (0...4).each do |y|
        arr.push(dat[i+y][x-y])
      end
      max = arr.reduce(:*) if arr.reduce(:*) > max
    end
  end
  return max
end

def eu12
  # Problem 12:
  # In the set of all triangle numbers, find the first
  # with more than 500 factors
  # Answer: 76,576,500
  def factors n
    count = 2
    root = n**0.5
    for i in 2..(root+1).to_i
      if n % i == 0
        count += 2
      end
    end
    count -= 1 if root**2 == n
    return count
  end
  n = 0
  tnum = 0
  while true
    n += 1
    tnum += n
    if factors(tnum) > 500
      return tnum
      false
    end
  end
end

def eu13
  # Problem 13:
  # Find the first ten digits of the sum 
  # of 100 50-digit numbers
  # Answer: 5,537,376,230
  farr = []
  open("files/eu13.txt", "r") do |file|
    file.each { |line| farr.push( line.to_i ) }
  end
  return farr.reduce(:+).to_s[0,10]
end

def eu14
  # Problem 14: 
  # Using the sequence n = n/2 when n is even
  # and n = 3n+1 when n is odd, which number  
  # less than one million produces the longest
  # sequence?
  # Answer: 837,799
  def collatz n
    len = 1
    while n > 1
      if n.even?
        n /= 2
      elsif n.odd?
        n = (n*3 + 1)
      end
      len += 1
    end
    return len
  end
  max = 0
  hi = 0
  (500_000..1_000_000).each do |i|
    if collatz(i) > max
      max = collatz(i)
      hi = i
    end
  end
  return hi
end

def eu15
  # Problem 15:
  # How many possible routes are there from
  # the top left corner to the bottom right
  # corner of a 20x20 grid, without backtracking
  # Answer: 137,846,528,820
  return 40.choose(20)
end

def eu16
  # Problem 16:
  # What is the sum of the digits of the number 2^1000?
  # Answer: 1,366
  bignum = (2**1000).to_s.split("")
  bignum.each_index { |i| bignum[i] = bignum[i].to_i }
  return bignum.reduce(:+)
end

def eu17
  # Problem 17:
  # If all the numbers from 1 to 1000 were written out in words,
  # how many letters would be used?
  # Answer: 21,124
  def numstring num
    ones = %w{zero one two three four five six seven eight nine ten}
    teens = %w{ ten eleven twelve thirteen fourteen fifteen sixteen }
    teens += %w{ seventeen eighteen nineteen }
    tens = %w{nil nil twenty thirty forty fifty sixty seventy eighty ninety}
    str = ""
    if num / 1000 > 0
      str += "#{ones[(num/1000)]} thousand "
      num = num % 1000
    end
    if num / 100 > 0
      str += "#{ones[(num/100)]} hundred "
      str += "and " if num % 100 > 0
      num = num % 100
    end
    if num % 100 > 0
      if num <= 10
        str += ones[num]
        return str
      elsif (num > 10) && (num < 20)
        str += teens[(num % 10)]
        return str
      elsif num >= 20
        if num % 10 == 0
          str += tens[(num/10)]
          return str
        elsif
          str += "#{tens[(num/10)]}-#{ones[(num%10)]}"
          return str
        end
      end
    end
    return str
  end
  total = 0
  (1..1000).each do |i|
    total += numstring(i).delete(" ").delete("-").length
  end
  return total
end

def eu18
  # Problem 18:
  # Given a triangle of numbers 15 high and 15 wide
  # find the maximum total sum moving from top to bottom
  # between adjacent numbers only
  # Answer: 1,074
  farr = []
  open("files/eu18.txt", "r") do |file|
    file.each { |line| farr.push(line.split(" ")) } 
  end
  farr = farr.map { |line| line.map { |item| item.to_i }}
  totals = [0]
  farr.each do |row|
    row.each_index do |i|
      if i == 0
        row[i] += totals[0]
      elsif i == row.length-1
        row[i] += totals[-1]
      else
        row[i] += [totals[i-1], totals[i]].max
      end
    end
    totals = row
  end
  return totals.max
end

def eu19
  # Problem 19:
  # How many Sundays fell on the first of the month during
  # the 20th century (1901-01-01..2000-12-31)
  # Answer: 171
  def a_(n); n % 7; end
  dim = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  dow = %w{ Sun Mon Tue Wed Thu Fri Sat }
  n = 2
  total = 0
  (0...1200).each do |i|
    y = (i / 12)+1
    i %= 12
    total += 1 if n == 0
    # puts "#{1900+y}: #{i+1} - #{dow[n]}"
    if y%4==0 and i==1
      if (1900+y)%100==0 and (1900+y)%400!=0
        n=a_(n+a_(dim[i]))
      else
        n=a_(n+a_(29))
      end
    else
      n=a_(n+a_(dim[i]))
    end
  end
  return total
end

def eu20
  # Problem 20:
  # Find the sum of the digits in the number 100!
  # Answer: 648
  (2..100).reduce(:*).to_s.split(//).reduce(0){|x,y| x+y.to_i}
end

def eu21
  # Problem 21:
  # Find the sum of all amicable numbers under 10,000
  # Anser: 31,626
  amic = []
  (1..10_000).each do |i|
    if i == i.sumdiv.sumdiv and i != i.sumdiv
      amic.push(i) if !(amic.has?(i))
      amic.push(i.sumdiv) if !(amic.has?(i))
    end
  end
  return amic.reduce(:+)
end

def eu22
  # Problem 22:
  # Using the names.txt file, find the sum of the name scores
  # for every first name
  # Answer: 871,198,282
  farr = []
  open("files/eu22.txt", "r") do |file|
    file.each {|line| farr.push(line.split(","))}
  end
  farr.flatten!
  farr.sort!
  farr = farr.map{ |item| item.tr('"', '') }
  avals = {}
  alpha = ('A'..'Z').each
  (1..26).each{ |i| avals[alpha.next] = i }
  nscores = Array::new(farr.length, 0)
  farr.each_index do |i|
    (0...farr[i].length).each do |x|
      nscores[i] += avals[(farr[i][x])]
    end
    nscores[i] *= (i+1)
  end
  return nscores.reduce(:+)
end

def eu23
  # Problem 23:
  # Find the sum of all positive integers which cannot be written
  # as the sum of two abundant numbers
  # Answer: 4,179,871
  abun = []
  (1..28123).each {|i| abun.push(i) if i.abundant?}
  abunodd = abun.map{ |x| x if x%2 != 0 }.compact
  odds = (957..28123).step(2).to_a
  odds += ((1..36).to_a-[24, 30, 32, 36, 945])
  odds += (37...957).step(2).to_a
  odds.push(46)
  abunodd.each do |odd|
    odds -= abun.map.collect{ |x| x+odd }
  end
  return odds.reduce(:+)
end

def eu24
  # Problem 24:
  # Find the one millionth lexicographic permutation of the digits (0..9)
  # Answer: 2,783,915,460
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
  return findpermno((0..9).to_a, 1000000).join("")
end

def eu25
  # Problem 25:
  # What is the first term in the Fibonacci sequence to contain 1000 digits
  # Answer: 4,782
  def fiboy(test_term=true, return_termno=false)
    # Severely over-engineered method for the purposes of the problem, but a 
    # robust Fibonacci tester will probably come in handy
    a, b, f = 0, 1, 1
    loop do
      a, b = b, a+b
      f += 1
      if test_term
        if yield(b)
          return f if return_termno
          return b
        end
      else
        if yield(f)
          return f if return_termno
          return b
        end
      end
    end
  end
  return fiboy(true, true) { |x| x if x.length >= 1000 }
end

def eu26
  # Problem 26:
  # For all the numbers 1...1000 find the number for which 1/n has the
  # longest recurring decimal sequence
  # Answer: 983
  def cycle(n)
    maxlen = 0
    rest = 1
    (0...n).each do |i|
      rest = (rest * 10) % n
    end
    r0 = rest
    len = 0
    loop do
      rest = (rest * 10) % n
      len += 1
      break if rest == r0
    end
    return len
  end
  maxlen = 0
  maxn = 0
  (901...1000).step(2) do |n|
    next if !n.prime?
    if cycle(n) > maxlen
      maxlen = cycle(n)
      maxn = n
    end
  end
  return maxn
end

def eu27
  # Problem 27:
  # Find the products of the coefficients a and b for the quadratic equation
  # that produces the maximum number of primes for consecutive values of n
  # starting with n = 0
  # Answer: -59,231
  def euquad(a, b, n)
    (n**2) + (a*n) + b
  end
  def quadlen(y)
    len, n =  0, 0
    loop do
      if y.call(n).prime?
        len += 1
        n += 1
      else
        break
      end
    end
    return len
  end
  maxlen = 0
  product = 0
  (1...1000).step(2) do |a|
    (1...1000).step(2) do |b|
      [a, -a].each do |t| 
        [b, -b].each do |v| 
          y = lambda { |n| euquad(t, v, n) }
          if quadlen(y) > maxlen
            maxlen = quadlen(y)
            product = t * v
          end
        end
      end
    end
  end
  return product
end

def eu28
  # Problem 28:
  # Find the sum of the numbers on the diagonals in a 1001 by 1001
  # spiral, formed by incrementing in a clockwise direction with 1
  # at the center
  # Answer: 669,171,001
  n = 1
  inc = 2
  d1 = 0
  d2 = 0
  while inc < 1002
    2.times do
      n += inc
      d1 += n
      n += inc
      d2 += n
    end
    inc += 2
  end
  return (d1+d2+1)
end

def eu29
  # Problem 29:
  # For the equation a^b where a=(1..100) and b=(1..100):
  # How many distinct terms are created out of these 1,000 iterations 
  # Answer: 9,183
  ans = []
  (2..100).each do |a|
    (2..100).each do |b|
      ans.push(a**b)
    end
  end
  return ans.uniq.length
end

def eu30
  # Problem 30:
  # Find the sum of all numbers that can be written as the sum of the
  # fifth powers of their digits
  # Answer: 443,839
  y = lambda { |n| n == n.to_a.map {|i| i**5}.reduce(:+) }
  (2..354294).collect{ |n| n if y.call(n) }.compact.reduce(:+)
end

def eu31
  # Problem 31:
  # Using the eight British coins in general circulation: how many ways 
  # can 2GBP be made using any number of coins?
  # AKA: An Ode to Lisp
  # Answer: 73,682
  count = 0
  200.step(0, -200) {|a|
      a.step(0, -100) {|b|
          b.step(0, -50){|c|
              c.step(0, -20){|d|
                  d.step(0, -10){|e|
                      e.step(0, -5){|f| 
                          f.step(0, -2){|g|
                              count += 1}}}}}}}
  return count
end

def eu32
  # Problem 32:
  # Find the sum of all products, whose multiplicand * multiplier = product
  # identity can be written as a 1..9 pandigital
  # Answer: 45,228
  found = Array.new
  1.upto(9) do |a|
    sa = a.to_s
    1234.upto(9876) do |b|
      s = sa + b.to_s
      next if s.delete('0').split(//).uniq.length < s.length
      s = s + (a*b).to_s
      break if s.length > 9
      found << (a*b) if s.delete('0').split(//).uniq.length == 9
    end
  end
  10.upto(98) do |a|
    sa = a.to_s
    123.upto(987) do |b|
      s = sa + b.to_s
      next if s.delete('0').split(//).uniq.length < s.length
      s = s + (a*b).to_s
      break if s.length > 9
      found << (a*b) if s.delete('0').split(//).uniq.length == 9
    end
  end
  sum = 0
  found.uniq.each do |i|
    sum = sum + i
  end
  return sum
end

def eu33
  # Problem 33:
  # 49/98 = 4/8, a correct answer that can be obtained by incorrectly 
  # cancelling the 9's. Excluding cases like 30/50 there are exactly
  # four examples of this type of fraction, < 1 in value. If the product
  # of these four is given in its lowest terms, find the value of its
  # denominator
  # Answer: 100
  results = []
  (10..99).each do |num|
    (10..99).each do |denom|
      numa, denoma = num.to_a, denom.to_a
      numa.each do |numchar|
        if denoma.has?(numchar) and numchar != 0
          numa.delete_at(numa.index(numchar))
          denoma.delete_at(denoma.index(numchar))
          numa, denoma = numa.join.to_f, denoma.join.to_f
          cancelled = numa / denoma
          orig = num.to_f / denom.to_f
          results.push([num, denom]) if cancelled == orig && num != denom && orig < 1
        end
      end
    end
  end
  fnum, fden = 1, 1
  results.each { |item| fnum, fden = fnum * item[0], fden * item[1] }
  return (1.0 /  (fnum.to_f / fden.to_f)).to_i
end

def eu34
  # Find the sum of all numbers which are equal to the sum of 
  # the factorial of their digits.
  # Answer: 40,730
  total = 0
  (3..100_000).each do |x|
    total += x if x == x.sum_of_digit_factorials 
  end
  total
end

def eu35
  # Problem 35:
  # 197 is a circular prime, because all rotations of the digits are also prime:
  # 197, 971, 719. How many of these numbers exist below 1,000,000.
  # Answer: 55
  circulars = [2]
  (3...1_000_000).step(2).each do |x|
    circulars.push(x) if x.circular_prime?
  end
  circulars.length
end

def eu36
  # Find the sum of all numbers, less than one million,
  # which are palindromic in base 10 and base 2
  # Answer: 872,187
  total = 0
  (1...1_000_000).each do |n|
    if n.palindrome? && n.to_bin.palindrome?
      total += n
    end
  end
  total
end

def eu37
  # The number 3797 has an interesting property. Being prime itself, 
  # it is possible to continuously remove digits from left to right, 
  # and remain prime at each stage: 3797, 797, 97, and 7. Similarly 
  # we can work from right to left: 3797, 379, 37, and 3.
  # 
  # Find the sum of the only eleven primes that are truncatable 
  # from both left to right and right to left.
  # Answer: 748,317
  def truncatable n 
    nstr = n.to_s
    (0...nstr.length).each do |x|
      # Truncating left to right
      return false if not nstr[0..x].to_i.prime?
      # Truncating right to left
      return false if not nstr[x...nstr.length].to_i.prime?
    end
    return true 
  end
  n = 11
  count, total = 0, 0
  while (count < 11)
    if truncatable n
      count += 1
      total += n
    end
    n += 2
  end
  return total
end

def eu38
  # What is the largest 1 to 9 pandigital 9-digit number that can be formed as 
  # the concatenated product of an integer with (1,2, ... , n) where n  1?
  # Answer: 932,718,654
  max = 0
  (1..10_000).each do |x|
    stringed = x.to_s
    next if stringed[0] != '9'
    n = 2
    loop do
      stringed << (x * n).to_s
      n += 1 
      break if stringed.length >= 9
    end
    if stringed.to_i.pandigital19?
      max = stringed.to_i if stringed.to_i > max 
    end
  end
  return max
end

def eu39
  # p is the combined length of all three sides of a right triangle. Values of p
  # can have multiple solutions with the same overall length. Find the value for
  # p, less than 1,000, that has the largest number of possible solutions
  # Answer: 840
  count = []
  (0..1000).each do |i|
    count[i] = 0
  end
  (1..25).each do |x|
    (1..25).each do |y|
      (1..25).each do |k|
        n = pytrips(x,y,k).inject(:+)
        if (n < 1000) and n > 0
          count[n] += 1
        end
      end
    end
  end
  return count.each_with_index.max[1]
end

def eu40
  # In a million digit number, where Dn represents the nth number in the 
  # sequence find the value of the following expresson
  # D1 * D10 * D100 * D1000 * D10000 * D100000 * D1000000
  # Answer: 210
  n = 1
  champ = "0"
  while (champ.length < 1_000_001)
    champ << n.to_s
    n += 1
  end
  return champ[1].to_i * champ[10].to_i * champ[100].to_i * champ[1_000].to_i \
  * champ[10_000].to_i * champ[100_000].to_i * champ[1_000_000].to_i
end

# # # # # # # # # # # 
# Execution Area
# # # # # # # # # # # 

if __FILE__ == $0

  puts "Project Euler Problem 1:\t#{eu1.to_hr}"
  puts "Project Euler Problem 2:\t#{eu2.to_hr}"
  puts "Project Euler Problem 3:\t#{eu3.to_hr}"
  puts "Project Euler Problem 4:\t#{eu4.to_hr}"
  puts "Project Euler Problem 5:\t#{eu5.to_hr}"
  puts "Project Euler Problem 6:\t#{eu6.to_hr}"
  puts "Project Euler Problem 7:\t#{eu7.to_hr}"
  puts "Project Euler Problem 8:\t#{eu8.to_hr}"
  puts "Project Euler Problem 9:\t#{eu9.to_hr}"
  puts "Project Euler Problem 10:\t#{eu10.to_hr}"
  puts "Project Euler Problem 11:\t#{eu11.to_hr}"
  puts "Project Euler Problem 12:\t#{eu12.to_hr}"
  puts "Project Euler Problem 13:\t#{eu13.to_hr}"
  puts "Project Euler Problem 14:\t#{eu14.to_hr}"
  puts "Project Euler Problem 15:\t#{eu15.to_hr}"
  puts "Project Euler Problem 16:\t#{eu16.to_hr}"
  puts "Project Euler Problem 17:\t#{eu17.to_hr}"
  puts "Project Euler Problem 18:\t#{eu18.to_hr}"
  puts "Project Euler Problem 19:\t#{eu19.to_hr}"
  puts "Project Euler Problem 20:\t#{eu20.to_hr}"
  puts "Project Euler Problem 21:\t#{eu21.to_hr}"
  puts "Project Euler Problem 22:\t#{eu22.to_hr}"
  puts "Project Euler Problem 23:\t#{eu23.to_hr}"
  puts "Project Euler Problem 24:\t#{eu24.to_hr}"
  puts "Project Euler Problem 25:\t#{eu25.to_hr}"
  puts "Project Euler Problem 26:\t#{eu26.to_hr}"
  puts "Project Euler Problem 27:\t#{eu27.to_hr}"
  puts "Project Euler Problem 28:\t#{eu28.to_hr}"
  puts "Project Euler Problem 29:\t#{eu29.to_hr}"
  puts "Project Euler Problem 30:\t#{eu30.to_hr}"
  puts "Project Euler Problem 31:\t#{eu31.to_hr}"
  puts "Project Euler Problem 32:\t#{eu32.to_hr}"
  puts "Project Euler Problem 33:\t#{eu33.to_hr}"
  puts "Project Euler Problem 34:\t#{eu34.to_hr}"
  puts "Project Euler Problem 35:\t#{eu35.to_hr}"
  puts "Project Euler Problem 36:\t#{eu36.to_hr}"
  puts "Project Euler Problem 37:\t#{eu37.to_hr}"
  puts "Project Euler Problem 38:\t#{eu38.to_hr}"
  puts "Project Euler Problem 39:\t#{eu39.to_hr}"
  puts "Project Euler Problem 40:\t#{eu40.to_hr}"

end
