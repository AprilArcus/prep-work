def vend(coin)
	[coin/2, coin/3, coin/4] # integer division
end

def ocd!(purse)
	purse.map! { |coin| coin.nonzero? ? vend(coin) : 0 }
	purse.flatten!
end

def wonky_coins(start_coin)
	purse = [start_coin]
	ocd! purse while purse.any? { |coin| coin > 0 }
	purse.length
end