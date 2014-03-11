# $words = File.open('/usr/share/dict/words').each_line.inject([]) do |result, line|
# 	result << line.chomp
# 	result
# end

def anagram?(s1,s2)
	s1.chars.sort == s2.chars.sort
end

def word_unscrambler(str, words=$words)
	words.select{ |word| anagram?(str,word) }
end