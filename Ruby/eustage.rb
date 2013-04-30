require './lib/euler_string'
require './lib/euler_array'
require './lib/euler_integer'
require './lib/euler_helper'
require './lib/fast_prime'
require './lib/helpers'
require 'set'

# An irrational decimal fraction is created by concatenating the positive integers:

# 0.123456789101112131415161718192021...

# It can be seen that the 12th digit of the fractional part is 1.

# If dn represents the nth digit of the fractional part, find the value of the 
# following expression.

# d1  d10  d100  d1000  d10000  d100000  d1000000

def eu40
  n = 1
  champ = "0"
  while (champ.length < 1_000_001)
    champ << n.to_s
    n += 1
  end
  return champ[1].to_i * champ[10].to_i * champ[100].to_i * champ[1_000].to_i \
  * champ[10_000].to_i * champ[100_000].to_i * champ[1_000_000].to_i
end

puts eu40












