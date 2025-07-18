require 'bigdecimal'
require 'bigdecimal/util'
require 'bigdecimal/math'
include BigMath
BigDecimal.limit(200)
Debug = false
V5 = BigMath.sqrt(BigDecimal('5'), 100)
Phi = (BigDecimal('1') + V5) / BigDecimal('2')

a = 0
b = 0
i = 10
# while a == b && i < 10_000

def fibonachi(n)
  start_time = Time.now.to_f
  output = Array.new(n)
  return if n <= 0

  n.times do |i|
    output[i] = if i <= 1
                  i
                else
                  output[i - 1] + output[i - 2]
                end
  end
  end_time = Time.now.to_f
  execute_time = (end_time - start_time) * 1000
  p "loop fibonachi execute Time: #{execute_time}ms"
  output[n - 1]
end

def recursive_fibo(f)
  return if f == 0
  return 1 if f == 1

  arr = Array.new(f)
  arr[0] = 1
  arr[1] = 1
  start_ = 2
  end_ = f

  fibo1 = lambda do |arr, start_ = 0, end_ = 0|
    return if start_ == end_ - 1

    puts 'This was printed recursively'
    n = start_
    arr[n] = arr[n - 1] + arr[n - 2]
    start_ += 1
    fibo1.call(arr, start_, end_)
  end

  start_time = Time.now
  fibo1.call(arr, start_, end_)
  arr[f - 2]
end

def recursive_fibo_extended(f)
  start_time_all = Time.now
  arr = Array.new(f)
  arr[0] = 1
  arr = arr

  fibo1 = lambda do |arr, start_ = 0, end_ = 0|
    start_time_fibo1 = Time.now
    if start_ == end_
      end_time_fibo1 = Time.now if Debug
      execute_time_fibo1 = (end_time_fibo1.to_f - start_time_fibo1.to_f) * 1000 if Debug
      p "fibo1 executetime: #{execute_time_fibo1}ms" if Debug
      return
    end

    inner_fibo = lambda do |arr, start_, end_|
      start_time_inner = Time.now
      if start_ == end_
        end_time_inner = Time.now if Debug
        execute_time_inner = (end_time_inner.to_f - start_time_inner.to_f) * 1000 if Debug
        p "inner1 executetime: #{execute_time_inner}ms" if Debug
        return
      end

      n = start_
      arr[n] = arr[n - 1] + arr[n - 2]
      start_ += 1
      inner_fibo.call(arr, start_, end_)
    end

    inner_fibo.call(arr, start_, end_) if !arr[start_ - 1].nil? && !arr[start_ - 2].nil?

    if arr[start_ - 1].nil? || arr[start_ - 2].nil?
      p "start-1:#{arr[start_ - 1]}start-2:#{arr[start_ - 2]}" if Debug
      start_time_calc = Time.now if Debug
      b = (Phi.power(start_) / V5).round.to_i
      end_time_calc = Time.now if Debug
      calc_time = (end_time_calc.to_f - start_time_calc.to_f) * 1000 if Debug
      p "calc executetime: #{calc_time}ms" if Debug
      arr[start_] = b
    end
    start_ += 1
    fibo1.call(arr, start_, end_)
  end

  fibo1.call(arr, 0, arr.length / 2)
  fibo1.call(arr, (arr.length / 2) + 1, arr.length)

  end_time_all = Time.now
  execute_time_all = (end_time_all.to_f - start_time_all.to_f) * 1000

  p "recursive Fibonachi execute Time: #{execute_time_all}ms"
  arr[arr.length - 1]
end
a = recursive_fibo(10)
b = fibonachi(8)
i += 1

# end

p "i: #{i} a:#{a} b:#{b}"
