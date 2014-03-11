def nearest_larger(arr, i) #would be readable in python
  offsets = arr.each.with_index.inject([]) do |result, (value, index)|
    result << index-i if value > arr[i]
    result
  end
  return nil if offsets.empty?
  offsets.sort_by! { |offset| [offset.abs, offset] }
  i+offsets.first
end

def nearest_larger(arr, i) # fast
  x = arr[i]
  max = arr.length
  ∆ = 1
  loop do
    l = i-∆
    r = i+∆
    ∆ += 1
    return l if (l >= 0) && (arr[l] > x)
    return r if (r < max) && (arr[r] > x)
    return nil if (l < 0) && (r >= max)
  end
end