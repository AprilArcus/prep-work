def letter_count(str)
	str.delete(' ').chars.inject({}) do |result, char|
		if result.include?char
			result[char] += 1
		else
			result[char] = 1
		end
		result
	end
end