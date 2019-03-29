module Enumerable
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

  def my_reduce
    p 'soy my reduce'
  end

  def my_select
    p 'soy my select'
  end

  def my_all?
    p 'soy my all?'
  end

  def my_any?
    p 'soy my any?'
  end

  def my_none?
    p 'soy my none?'
  end

  def my_count
    p 'soy my count'
  end

  def my_map
    p 'soy my map'
  end

  def my_inject
    p 'soy my inject'
  end
end

# irb(main):030:0> numbers
# => [1, 2, 3, 4, 5]

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