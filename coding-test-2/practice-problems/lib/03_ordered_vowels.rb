def ordered_vowel_word?(word)
	word.chars.keep_if{ |c| 'aeiou'.include?c }.each_cons(2) do |vowel_pair|
		return false if vowel_pair[1] < vowel_pair[0]
	end
	true
end

def ordered_vowel_words(str)
	fail unless str.chars.all? { |char| char == char.downcase }
	str.split.keep_if{ |word| ordered_vowel_word?word }.join(' ')
end