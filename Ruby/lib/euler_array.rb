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
