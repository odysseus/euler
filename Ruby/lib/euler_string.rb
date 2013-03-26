class String
	def to_hr; self; end
	def palindrome?
		return false if self[0] == "0"
		self == self.reverse
	end
end
