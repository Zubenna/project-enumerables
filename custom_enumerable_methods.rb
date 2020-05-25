module Enumerable
  def my_each
    return to_enum unless block_given?

    x = 0
    self_class = self.class
    array = if self_class == Array
              self
            elsif self_class == Range
              to_a
            else
              flatten
            end
    while x < array.length
      if self_class == Hash
        yield array[x], array[x + 1]
        x += 2
      else
        yield array[x]
        x += 1
      end
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    self_class = self.class
    x = 0
    array = self_class == Array ? self : to_a
    while x < array.length
      yield array[x], x
      x += 1
    end
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

  def my_all?(my_parameter = nil)
    return true if (self.class == Array && count.zero?) || (!block_given? &&
        my_parameter.nil? && !include?(nil))
    return false unless block_given? || !my_parameter.nil?

    result = true
    if self.class == Array
      my_each do |x|
        if block_given?
          result = false unless yield(x)
        elsif my_parameter.class == Regexp
          result = false unless x.match(my_parameter)
        elsif my_parameter.class <= Numeric
          result = false unless x == my_parameter
        else
          result = false unless x.class <= my_parameter
        end
        break unless result
      end
    else
      my_each do |key, value|
        result = false unless yield(key, value)
      end
    end
    result
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

  def my_map
    return to_enum unless block_given?

    new_array = []
    if self.class == Array
      my_each do |n|
        new_array << yield(n)
      end
    else
      my_each do |key, value|
        new_array << yield(key, value)
      end
    end
    new_array
  end

  def my_inject(symbol = nil, start_value = nil)
    if symbol.class != Symbol
      holder = symbol
      symbol = start_value
      start_value = holder
    end
    initial_value = false
    initial_value = true unless start_value.nil?
    value = start_value || first
    case symbol
    when :+
      if !initial_value
        drop(1).my_each do |x|
          value += x
        end
      else
        my_each do |x|
          value += x
        end
      end
    when :*
      if !initial_value
        drop(1).my_each do |x|
          value *= x
        end
      else
        my_each do |x|
          value *= x
        end
      end
    when :/
      if !initial_value
        drop(1).my_each do |x|
          value /= x
        end
      else
        my_each do |x|
          value /= x
        end
      end
    when :-
      if !initial_value
        drop(1).my_each do |x|
          value -= x
        end
      else
        my_each do |x|
          value -= x
        end
      end
    when :**
      if !initial_value
        drop(1).my_each do |x|
          value **= x
        end
      else
        my_each do |x|
          value **= x
        end
      end
    else
      if !initial_value
        drop(1).my_each do |x|
          value = yield(value, x)
        end
      else
        my_each do |x|
          value = yield(value, x)
        end
      end
    end
    value
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
puts
# Calling my_map with a proc
test_proc = proc { |i| i * 5 }
test_array = [5, 7, 9, 5]
puts 'array.my_map(&test_proc) output: ' + test_array.my_map(&test_proc).to_s



