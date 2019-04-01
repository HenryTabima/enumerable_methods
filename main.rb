# Enumerable Module extension
module Enumerable

  def my_each
    i = 0
    while i < length
      yield(at(i))
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < length
      yield(at(i), i)
      i += 1
    end
    self
  end

  def my_inject(carry = at(0))
    i = carry == at(0) ? 1 : 0
    while i < length
      carry = yield(carry, at(i))
      i += 1
    end
    carry
  end
  alias my_reduce my_inject

  def my_select
    selected = []
    for i in self
      selected << i if yield(i)
    end
    selected
  end

  def my_all?
    result = true
    for i in self
      result &&= yield(i)
      break unless result
    end
    result
  end

  def my_any?
    result = false
    for i in self
      result ||= yield(i)
      break if result
    end
    result
  end

  def my_none?
    result = false
    for i in self
      result ||= yield(i)
      break if result
    end
    !result
  end

  def my_count(obj = nil)
    count = 0
    for i in self
      cond = block_given? ? yield(i) : (obj || i) == i
      count += 1 if cond
    end
    count
  end

  def my_map(proc = nil)
    return self if proc.nil? && !block_given?

    new_array = []
    for i in self
      next_value = proc.nil? ? yield(i) : proc.call(i)
      new_array << next_value
    end
    new_array
  end
end

# ***** Variables *****
# > numbers = (1..5).to_a
# => [1, 2, 3, 4, 5]
# ----------------------
# > double = Proc.new { |n| n * 2 }
# => #<Proc:0x000055a7c5c18960@(irb):58>

# ***** My Each *****
# > numbers.each { |n| print n }
# 12345=> [1, 2, 3, 4, 5]
# > numbers.my_each { |n| print n }
# 12345=> [1, 2, 3, 4, 5]

# ***** My Each with index *****
# > numbers.each_with_index { |n, i| puts "number: #{n} index: #{i}" }
# number: 1 index: 0
# number: 2 index: 1
# number: 3 index: 2
# number: 4 index: 3
# number: 5 index: 4
# => [1, 2, 3, 4, 5]
# > numbers.my_each_with_index { |n, i| puts "number: #{n} index: #{i}" }
# number: 1 index: 0
# number: 2 index: 1
# number: 3 index: 2
# number: 4 index: 3
# number: 5 index: 4
# => [1, 2, 3, 4, 5]

# ***** My Inject *****
# > numbers.inject { |mul, n| mul * n }
# => 120
# > numbers.my_inject { |mul, n| mul * n }
# => 120

# ***** My Select *****
# > numbers.select { |n| n > 2 }
# => [3, 4, 5]
# > numbers.my_select { |n| n > 2 }
# => [3, 4, 5]

# ***** My All? *****
# > numbers.all? { |n| n < 6 }
# => true
# > numbers.my_all? { |n| n < 6 }
# => true
# -----------------
# > numbers.all? { |n| n < 4 }
# => false
# > numbers.my_all? { |n| n < 4 }
# => false

# ***** My Any? *****
# > numbers.any? { |n| n == 4 }
# => true
# > numbers.my_any? { |n| n == 4 }
# => true
# -----------------
# > numbers.any? { |n| n == 6 }
# => false
# > numbers.my_any? { |n| n == 6 }
# => false

# ***** My None? *****
# > numbers.none? { |n| n > 6 }
# => true
# > numbers.my_none? { |n| n > 6 }
# => true
# -----------------
# > numbers.none? { |n| n > 4 }
# => false
# > numbers.my_none? { |n| n > 4 }
# => false

# ***** My count *****
# > numbers.count
# => 5
# > numbers.my_count
# => 5
# -----------------
# > numbers.count(2)
# => 1
# > numbers.my_count(2)
# => 1
# -----------------
# > numbers.count { |n| n <= 3 }
# => 3
# > numbers.my_count { |n| n <= 3 }
# => 3

# ***** My Map *****
# > numbers.my_map
# => [1, 2, 3, 4, 5]
# > numbers.my_map(&double)
# => [2, 4, 6, 8, 10]
# > numbers.my_map(double)
# => [2, 4, 6, 8, 10]
# > numbers.my_map { |n| n * 2 }
# => [2, 4, 6, 8, 10]
# > numbers.my_map(double) { |n| n * 3 }
# => [2, 4, 6, 8, 10]
