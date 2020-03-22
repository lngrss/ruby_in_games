def merge_sort(arr)
  if arr.size < 2
    arr
  else
    result = []
    l  = merge_sort(arr[0...(arr.size / 2)])
    r  = merge_sort(arr[(arr.size / 2)..])
    l_i, r_i = 0, 0
    while (l_i < l.size && r_i < r.size)
      if l[l_i] < r[r_i]
        result << l[l_i]
        l_i += 1
      else
        result << r[r_i]
        r_i += 1
      end
    end
    l[l_i..].empty? ? result = result + r[r_i..] : result = result + l[l_i..]
    p "MERGED: #{result}"
    result
  end
end
