class Morse
	@@ascii = {:a => '.-',
	           :b => '-...',
	           :c => '-.-.',
	           :d => '-..',
	           :e => '.',
	           :f => '..-.',
	           :g => '--.',
	           :h => '....',
	           :i => '..',
	           :j => '.---',
	           :k => '-.-',
	           :l => '.-..',
	           :m => '--',
	           :n => '-.',
	           :o => '---',
	           :p => '.--.',
	           :q => '--.-',
	           :r => '.-.',
	           :s => '...',
	           :t => '-',
	           :u => '..-',
	           :v => '...-',
	           :w => '.--',
	           :x => '-..-',
	           :y => '-.--',
	           :z => '--..',
	         :'1' => '.----',
	         :'2' => '..---',
	         :'3' => '...--',
	         :'4' => '....-',
	         :'5' => '.....',
	         :'6' => '-....',
	         :'7' => '--...',
	         :'8' => '---..',
	         :'9' => '----.',
	         :'0' => '-----',
	         :'.' => '._._._',
	         :',' => '--..--',
	         :'?' => '..--..',
	        :'\'' => '.-----.',
	         :'!' => '-.-.--',
	         :'/' => '-..-.',
	         :'(' => '-.--.',
	         :')' => '-.--.-',
	         :'&' => '.-...',
	         :':' => '---...',
	         :';' => '-.-.-.',
	         :'=' => '-...-',
	         :'+' => '.-.-.',
	         :'-' => '-....-',
	         :'_' => '..__._',
	         :'"' => '.-..-.',
	         :'$' => '...-..-',
	         :'@' => '.--.-.',
	         :'ä' => '·–·–',
	         :'æ' => '·–·–',
	         :'ą' => '·–·–',
	         :'à' => '·––·–',
	         :'å' => '·––·–',
	         :'ç' => '–·–··',
	         :'ĉ' => '–·–··',
	         :'ć' => '–·–··',
	         :'š' => '----',
	         :'ĥ' => '----',
	        :'ch' => '----', # tricky!
	         :'ð' => '..--.',
	         :'ś' => '...-...',
	         :'è' => '.-..-',
	         :'ł' => '.-..-',
	         :'é' => '..-..',
	         :'đ' => '..-..',
	         :'ę' => '..-..',
	         :'ĝ' => '--.-.',
	         :'ĵ' => '.---.',
	         :'ź' => '––··–·',
	         :'ñ' => '––·––',
	         :'ń' => '––·––',
	         :'ö' => '–––·',
	         :'ø' => '–––·',
	         :'ó' => '–––·',
	         :'ŝ' => '...-.',
	         :'þ' => '·––··',
	         :'ü' => '..--',
	         :'ŭ' => '..--',
	         :'ż' => '--..-',
	 :letterspace => ' ',
	   :wordspace => '  '}

	private
	def self.init_binary
		intra_character_gap = '0'
		binary = @@ascii.inject({}) do |result, (key, value)|
			result[key] = value.chars.join(intra_character_gap).gsub(/\./,'1').gsub(/-/,'111')
			result
		end
		binary[:letterspace] = '0'*3
		binary[:wordspace] = '0'*7
		binary
	end

	@@binary = init_binary()

	private
	def self.encode(str,dict)
		begin
			require 'unf'
			unicode = true
			iterable = UNF::Normalizer.normalize(str.downcase, :nfkc).chars
		rescue LoadError
			begin
				require 'active_support/multibyte/unicode'
				unicode = true
				iterable = ActiveSupport::Multibyte::Unicode.normalize(str.downcase, :kc).chars
			rescue LoadError
				unicode = false
				iterable = str.downcase.chars
				warn '`gem install unf` or `gem install rails` for unicode support'
			end
		end
		iterable.each.with_index.inject('') do |result, (char,i)|
			if char
				#handle digraphs
				if unicode && iterable[i+2] && iterable[i+1]=="\u034F" #COMBINING GRAPHEME JOINER
					sym = (iterable[i]+iterable[i+2]).to_sym
					if dict.include?sym
						result += dict[sym]
						result += dict[:letterspace] if iterable[i+3] =~ /[[:graph:]]/
						iterable[i+1],iterable[i+2] = nil
						next result
					else
						#fall through
					end
				end
				#handle regular chars
				if char =~ /[[:space:]]/
					result += dict[:wordspace]
					next result
				elsif (unicode || char.codepoints[0]<128) && dict.include?(sym = char.to_sym)
					result += dict[sym]
					result += dict[:letterspace] if iterable[i+1] =~ /[[:graph:]]/
					next result
				end
			end
			result
		end
	end

	def self.encode_ascii(str)
		encode(str,@@ascii)
	end

	def self.encode_binary(str)
		encode(str,@@binary)
	end

end

def morse_encode(str)
	Morse.encode_ascii(str)
end