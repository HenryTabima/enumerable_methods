# Enumerable Module extension
module Enumerable
  alias my_reduce my_inject

  def my_each
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_inject(carry = self[0])
    i = carry == self[0] ? 1 : 0
    while i < length
      carry = yield(carry, self[i])
      i += 1
    end
    carry
  end

  def my_select
    selected = []
    my_each do |i|
      selected << i if yield(i)
    end
    selected
  end

  def my_all?
    my_inject(true) { |res, i| res && yield(i) }
  end

  def my_any?
    my_inject(false) { |res, i| res || yield(i) }
  end

  def my_none?
    !my_any? { |i| yield(i) }
  end

  def my_count(obj = nil)
    count = 0
    my_each do |i|
      cond = block_given? ? yield(i) : (obj || i) == i
      count += 1 if cond
    end
    count
  end

  def my_map(proc = nil)
    return self if proc.nil? && !block_given?

    my_inject([]) do |new_array, i|
      next_value = proc.nil? ? yield(i) : proc.call(i)
      new_array << next_value
    end
  end
end

# ***** Variables *****
# irb(main):030:0> numbers
# => [1, 2, 3, 4, 5]
# ----------------------
# irb(main):058:0> double = Proc.new { |n| n * 2 }
# => #<Proc:0x000055a7c5c18960@(irb):58>

# ***** My Each *****
# irb(main):031:0> numbers.each { |n| print n }
# 12345=> [1, 2, 3, 4, 5]
# irb(main):032:0> numbers.my_each { |n| print n }
# 12345=> [1, 2, 3, 4, 5]

# ***** My Each with index *****
# irb(main):036:0> numbers.each_with_index { |n, i| puts "number: #{n} index: #{i}" }
# number: 1 index: 0
# number: 2 index: 1
# number: 3 index: 2
# number: 4 index: 3
# number: 5 index: 4
# => [1, 2, 3, 4, 5]
# irb(main):037:0> numbers.my_each_with_index { |n, i| puts "number: #{n} index: #{i}" }
# number: 1 index: 0
# number: 2 index: 1
# number: 3 index: 2
# number: 4 index: 3
# number: 5 index: 4
# => [1, 2, 3, 4, 5]

# ***** My Inject *****
# irb(main):056:0> numbers.inject { |mul, n| mul * n }
# => 120
# irb(main):057:0> numbers.my_inject { |mul, n| mul * n }
# => 120

# ***** My Reduce *****
# irb(main):007:0> numbers.reduce { |sum, n| sum + n }
# => 15
# irb(main):008:0> numbers.my_reduce { |sum, n| sum + n }
# => 15

# ***** My Select *****
# irb(main):004:0> numbers.select { |n| n > 2 }
# => [3, 4, 5]
# irb(main):005:0> numbers.my_select { |n| n > 2 }
# => [3, 4, 5]

# ***** My All? *****
# irb(main):016:0> numbers.all? { |n| n < 6 }
# => true
# irb(main):017:0> numbers.my_all? { |n| n < 6 }
# => true
# -----------------
# irb(main):018:0> numbers.all? { |n| n < 4 }
# => false
# irb(main):019:0> numbers.my_all? { |n| n < 4 }
# => false

# ***** My Any? *****
# irb(main):020:0> numbers.any? { |n| n == 4 }
# => true
# irb(main):021:0> numbers.my_any? { |n| n == 4 }
# => true
# -----------------
# irb(main):022:0> numbers.any? { |n| n == 6 }
# => false
# irb(main):023:0> numbers.my_any? { |n| n == 6 }
# => false

# ***** My None? *****
# irb(main):030:0> numbers.none? { |n| n > 6 }
# => true
# irb(main):031:0> numbers.my_none? { |n| n > 6 }
# => true
# -----------------
# irb(main):032:0> numbers.none? { |n| n > 4 }
# => false
# irb(main):033:0> numbers.my_none? { |n| n > 4 }
# => false

# ***** My count *****
# irb(main):049:0> numbers.count
# => 5
# irb(main):050:0> numbers.my_count
# => 5
# -----------------
# irb(main):051:0> numbers.count(2)
# => 1
# irb(main):052:0> numbers.my_count(2)
# => 1
# -----------------
# irb(main):054:0> numbers.count { |n| n <= 3 }
# => 3
# irb(main):055:0> numbers.my_count { |n| n <= 3 }
# => 3

# ***** My Map *****
# irb(main):088:0> numbers.my_map
# => [1, 2, 3, 4, 5]
# irb(main):092:0> numbers.my_map(&double)
# => [2, 4, 6, 8, 10]
# irb(main):089:0> numbers.my_map(double)
# => [2, 4, 6, 8, 10]
# irb(main):090:0> numbers.my_map { |n| n * 2 }
# => [2, 4, 6, 8, 10]
# irb(main):091:0> numbers.my_map(double) { |n| n * 3 }
# => [2, 4, 6, 8, 10]
