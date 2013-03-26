#!/opt/local/bin/ruby1.9

# Brilliant solutions to Euler Problems

=begin
Problem 1:

These solutions use the idea that you can reverse engineer the problem
and calculate the multiples instead of checking for divisors, the first
method is faster because it checks for duplicate multiples and sums in 
one pass, whereas the other removes duplicates and then sums on 2nd pass.
Either way both solutions are much faster than my original one
=end

def eu1
  # .00028s | 1000 silent iterations
  total = 0
  (1..1000).each {|i| total += i if i % 3 == 0 or i % 5 == 0}
  return total
end

def eu1_1
  # 0.00014s | 1000 silent iterations
  3.step(999,3).reduce {|x,y|  y && y%5!=0 ? x+y : x}+
    5.step(999,5).reduce(:+)
end

def eu1_2
  # 0.00017s | 1000 silent iterations
  3.step(999,3).select{|x| x if x%5!=0}.reduce(:+)+
    5.step(999,5).reduce(:+)
end


=begin
Problem 2:

Two brilliant solutions here:
1 - The approx difference between any 2 numbers in the fibonacci sequence 
is phi, and every 3rd term is even, so every even term is ~phi^3 apart,
by rounding each even term and multiplying again you can generate the 
sequence easily

2- Because every 3rd term is even, you can algebraically represent the 
series as: x, y, *x+y*, x+2y, 2x+3y, *3x+5y*
The starred terms are the even ones, each iteration you add x+y to 
the total, then make [ x, y = x+2y, 2x+3y ] so that the sum will be
3x+5y on the next pass, repeat until the generated value exceeds 4mil
=end

# phi3 = 4.236068
# puts (2*phi3).round
# puts (8*phi3).round

class Fixnum
  def fibo
    a, b = 0, 1
    self.times { a, b = b, a+b }
    return b
  end
end

def eu2
  # 0.00004s | 1000 silent iterations
  total = 0
  a, b = 0, 1
  while b < 4000000
    total += b if b.even?
    a, b = b, a+b
  end
  return total
end

def eu2_1 
  # 0.00009s | 1000 silent iterations
  2.step(32, 3).reduce(0){|x,y| x+y.fibo} 
end


if __FILE__ == $0
  
  1000.times{ eu2 }
  
end


#### Scratch

# Project Euler Problem 20
class Fixnum; def _!; self.downto(1).to_a.reduce(:*); end; end
def eu20; 100._!.to_s.split(//).reduce(0){|x,y| x+y.to_i}; end; puts eu20 

puts (2..100).inject(1){|m,p| p*m}.to_s.split(//).inject(0) {|s,e| s+e.to_i}
puts (2..100).reduce(:*).to_s.split(//).reduce(0){|x,y| x+y.to_i}

def eu1_1
  3.step(1000, 3).reduce {|x, y|  y && y%5!=0 ? x+y : x}+5.step(1000,5).reduce(:+)
end

def eu1_2
  3.step(1000,3).select{|x| x if x%5!=0}.reduce(:+)+5.step(1000,5).reduce(:+)
end



