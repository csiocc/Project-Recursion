DEBUG = false
system 'clear'
array2 = Array.new(250_000) { rand(1..5000) }
## my first own merge_sort
#
def merge_sort(array)
  p "triggered merge_sort with #{array}" if DEBUG
  return array if array.length < 2 # return array to initilize another split

  if array.length >= 2
    half = array.length / 2
    first_half = merge_sort(array.take(half)).compact # trigger sorting if array length <= 2
    second_half = merge_sort(array.drop(half)).compact
    p "splitting #{array} into #{first_half} and #{second_half}" if DEBUG
  end
  sorted = []
  i = 0
  while !first_half.empty? || !second_half.empty?
    p "start megring #{first_half} and #{second_half}" if DEBUG

    sorted.push(first_half.slice!(0)) if second_half[0].nil?

    sorted.push(second_half.slice!(0)) if first_half[0].nil?

    if !first_half[0].nil? && !second_half[0].nil?
      sorted.push(first_half[0] <= second_half[0] ? first_half.slice!(0) : second_half.slice!(0))
    end
    p sorted if DEBUG
    i += 1
  end
  sorted
end

## my try to beat merge_sort
def mysort(array)
  p array if DEBUG
  result = Array.new(array.length)
  grouped = array.group_by { |e| e }
  hash_valued = grouped.map do |key, count|
    [key, { value: key, count: count }]
  end
  p hash_valued if DEBUG
  hash_valued.each do |key, data|
    p "#{key} inserting on #{data[:value] - 1}" if DEBUG
    index = (data[:value] - 1).to_i
    element = data[:count]
    result[index] = element
  end
  result.compact.flatten
end

# imported from dev.to to compare against my solutions
def merge_sort_import(array)
  return array if array.length <= 1

  array_size = array.length
  middle = (array.length / 2).round

  left_side = array[0...middle]
  right_side = array[middle...array_size]

  sorted_left = merge_sort_import(left_side)
  sorted_right = merge_sort_import(right_side)

  merge(array, sorted_left, sorted_right)

  array
end

def merge(array, sorted_left, sorted_right)
  left_size = sorted_left.length
  right_size = sorted_right.length

  array_pointer = 0
  left_pointer = 0
  right_pointer = 0

  while left_pointer < left_size && right_pointer < right_size
    if sorted_left[left_pointer] < sorted_right[right_pointer]
      array[array_pointer] = sorted_left[left_pointer]
      left_pointer += 1
    else
      array[array_pointer] = sorted_right[right_pointer]
      right_pointer += 1
    end
    array_pointer += 1
  end

  while left_pointer < left_size
    array[array_pointer] = sorted_left[left_pointer]
    left_pointer += 1
    array_pointer += 1
  end

  while right_pointer < right_size
    array[array_pointer] = sorted_right[right_pointer]
    right_pointer += 1
    array_pointer += 1
  end

  array
end

## Benchmarksection
#
start_t = Time.now
a = merge_sort(array2)
end_t = Time.now
aexecute_t = (end_t.to_f - start_t.to_f) * 1000
p "Time to execute merge_sort: #{aexecute_t.to_f.round(4)}ms" if aexecute_t < 1000
p "Time to execute merge_sort: #{(aexecute_t / 1000).to_f.round(4)} Sekunden" if aexecute_t > 1000

start_t = Time.now
b = mysort(array2)
end_t = Time.now
bexecute_t = (end_t.to_f - start_t.to_f) * 1000
p "Time to execute mysort: #{bexecute_t.to_f.round(4)}ms" if bexecute_t < 1000
p "Time to execute mysort: #{(bexecute_t / 1000).to_f.round(4)} Sekunden}" if bexecute_t > 1000

start_t = Time.now
c = merge_sort_import(array2)
end_t = Time.now
cexecute_t = (end_t.to_f - start_t.to_f) * 1000
p "Time to execute merge_sort_import: #{cexecute_t.to_f.round(4)}ms" if cexecute_t < 1000
p "Time to execute merge_sort_import: #{(cexecute_t / 1000).to_f.round(4)} Sekunden}" if cexecute_t > 1000

def compare(a, b, c)
  p 'merge_sort result equals mysort result' if a == b
  p 'mysort result equals merge_sort_import result' if b == c
  p '100% match' if a == b && b == c
  p 'merge_sort != mysort' if a != b
end

compare(a, b, c)

def fastest(aexecute_t, bexecute_t, cexecute_t)
  p "merge_sort wins with #{aexecute_t.to_f.round(4)}ms" if aexecute_t < bexecute_t && aexecute_t < cexecute_t
  p "mysort wins with #{bexecute_t.to_f.round(4)}ms" if bexecute_t < aexecute_t && bexecute_t < cexecute_t
  p "merge_sort_imported wins with #{cexecute_t.to_f.round(4)}ms" if cexecute_t < bexecute_t && cexecute_t < aexecute_t
end

fastest(aexecute_t, bexecute_t, cexecute_t)
