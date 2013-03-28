require '~/bin/extlib.rb'
require 'set'

# If p is the perimeter of a right angle triangle with integral length sides, 
# {a,b,c}, there are exactly three solutions for p = 120.

# {20,48,52}, {24,45,51}, {30,40,50}

# For which value of p  1000, is the number of solutions maximised?

def pytrips m, n, k
  def findtrips m, n, k
    a = k * (m**2 - n**2)
    b = k * (2*m*n)
    c = k * (m**2 + n**2)
    return [a, b, c].inject(:+)
  end
  if m == n
    return -1
  elsif m > n
    return findtrips(m, n, k)
  else
    return findtrips(n, m, k)
  end
end

def eu39
  count = []
  (0..1000).each do |i|
    count[i] = 0
  end
  (1..25).each do |x|
    (1..25).each do |y|
      (1..25).each do |k|
        n = pytrips(x,y,k)
        if (n < 1000) and n != -1
          count[n] += 1
        end
      end
    end
  end
  return count.each_with_index.max[1]
end


puts eu39











