def bubble_sort!(arr)
	sorted = false
	while not sorted
		sorted = true
		arr.each_cons(2).with_index do |vals, i|
			if vals[0] > vals[1]
				arr[i], arr[i+1] = arr[i+1], arr[i]
				sorted = false
			end
		end
	end
	arr
end

def bubble_sort(arr)
	result = Array.new(arr)
	bubble_sort!result
end