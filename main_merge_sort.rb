DEBUG = false
system 'clear'
array2 = Array.new(111_110) { rand(1..100) }

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
start_t = Time.now
p merge_sort(array2)
end_t = Time.now
execute_t = (end_t.to_f - start_t.to_f) * 1000
p "Time to execute: #{execute_t}ms"
