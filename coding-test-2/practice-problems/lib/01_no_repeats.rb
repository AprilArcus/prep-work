def no_repeat?(year) # using sets
	require 'set'
	string = year.to_s
	set = Set.new(string.chars)
	string.length == set.length
end

def no_repeat?(year) # using enumerators
	seen = []
	year.to_s.chars.each do |char|
		return false if seen.include?char
		seen << char
	end
	return true
end

def no_repeat?(year,base=10) # use divmod instead of string methods
	seen = []
	quotient = year
	while quotient > 0
		quotient, remainder = quotient.divmod(base)
		return false if seen.include?remainder
		seen << remainder
	end
	return true
end

def no_repeats(year_start, year_end)
	(year_start..year_end).to_a.keep_if { |y| no_repeat?(y) }
end
