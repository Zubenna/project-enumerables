module Enumerable
  def my_each
    return to_enum unless block_given?

    x = 0
    array = if self.class == Array
              self
            elsif self.class == Range
              to_a
            else
              flatten
            end
    while x < length
      if self.class == Hash
        yield(array[x], array[x + 1])
        x += 2
      else
        yield self[x]
        x += 1
      end
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    self_class = self.class
    x = 0
    array = self_class == Array ? self : to_a
    while x < array.length
      yield self[x], x
      x += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    my_enumerable = self.class == Array ? [] : {}
    if my_enumerable.class == Array
      my_each do |n|
        my_enumerable.push(n) if yield(n)
      end
    else
      my_each do |key, value|
        my_enumerable[key] = value if yield(key, value)
      end
    end
    my_enumerable
  end

  def my_all?(pattern = false)
    if block_given?
      my_each { |item| return false if !(yield item).nil? == false }
    elsif pattern.class == Class 
      my_each { |x| return false unless x.is_a? pattern }
    elsif pattern.class == Regexp
      my_each { |x| return false unless x.match? pattern }
    elsif !pattern.nil? == true
      my_each { |item| return false if (pattern === item) == false }
    else
      my_each { |item| return false if !item.nil? == false }
    end
    true
  end

  def my_any?(our_parameter = nil)
    return false if (self.class == Array && count.zero?) || (!block_given? &&
    our_parameter.nil? && !include?(true))
    return true unless block_given? || !our_parameter.nil?

    result = false
    if self.class == Array
      my_each do |i|
        if block_given?
          result = true if yield(i)
        elsif our_parameter.class == Regexp
          result = true if i.match(our_parameter)
        elsif our_parameter.class == String
          result = true if i == our_parameter
        elsif i.class <= our_parameter
          result = true
        end
      end
    else
      my_each do |key, value|
        result = true if yield(key, value)
      end
    end
    result
  end

  def my_none?(my_parameter = nil)
    return true if count.zero? || (self[0].nil? && !include?(true))
    return false unless block_given? || !my_parameter.nil?

    result = true
    if self.class == Array
      my_each do |x|
        if block_given?
          result = false if yield(x)
        elsif my_parameter.class == Regexp
          result = false if x.match(my_parameter)
        elsif my_parameter.class <= Numeric
          result = false if x == my_parameter
        elsif x.class <= my_parameter
          result = false
        end
        break unless result
      end
    else
      my_each do |key, value|
        result = false if yield(key, value)
        break unless result
      end
    end
    result
  end

  def my_count(my_variable = nil)
    my_counter = 0
    if block_given?

      if self.class == Array
        my_each do |n|
          my_counter += 1 if yield(n)
        end
      else
        my_each do |key, value|
          my_counter += 1 if yield(key, value)
        end
      end
    elsif !block_given? && my_variable.nil?
      return length
    elsif !block_given? && !my_variable.nil?
      my_each do |n|
        my_counter += 1 if n == my_variable
      end
    end
    my_counter
  end

  def my_map(my_proc = nil)
    result_array = []
    if !my_proc
      return to_enum unless block_given?

      my_each { |x| result_array << yield(x) }
    else
      my_each { |x| result_array << my_proc.call(x) }
    end
    result_array
  end

  def my_inject(*param)
    array = is_a?(Range) ? to_a : self

    result = param[0] if param[0].is_a?(Integer)
    operator = param[0].is_a?(Symbol) ? param[0] : param[1]

    if operator
      array.my_each { |item| result = result ? result.send(operator, item) : item }
      return result
    end
    array.my_each { |item| result = result ? yield(result, item) : item }
    result
  end
end

# Testing my_inject with multiply_els method
def multiply_els(arr)
  arr.my_inject do |parameter, n|
    parameter * n
  end
end

puts
puts 'multiply_els([2, 4, 5]) output: ' + multiply_els([2, 4, 5]).to_s
puts

# Executes only the proc when both a block and a proc are given
square = proc { |n| n**2 }
p([1, 2, 3].my_map(square))
p([1, 2, 3].my_map { |n| n**2 })

p([1, 2, 3, 4].my_all?(Integer)) # should return true
p(%w[dog, door, doll].my_all?(/d/)) # should return true
p([1, 2, false].my_all?)

