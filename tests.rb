require './custom_enumerable_methods.rb'

# Sample arrays and hash used in testing the enumerable methods.
test_array = [5, 7, 9, 5]
test_hash = { w: 3, x: 4, y: 2, z: 6 }
test_words = %w[cat house tree fan]

# Tests for #my_each
puts
print 'test_array.my_each { |n| n } output: '
test_array.my_each { |n| print n }
puts
print 'test_words.my_each { |n| n } output: '
test_words.my_each { |n| print n }
puts
puts 'test_hash.each { |key, value| puts Key: "#{key}, Value: #{value}"} output:'
test_hash.my_each { |key, value| puts "Key: #{key}, Value: #{value}" }
puts
puts

# Tests for #my_each_with_index
puts 'test_array.my_each_with_index do |element, index|
puts "Index: #{index}, Element:#{element}"
end output: '
  test_array.my_each_with_index do |element, index|
    puts "Index: #{index}, Element:#{element}"
  end
puts 'test_words.my_each_with_index do |element, index|
puts "Index: #{index}, Element:#{element}"
end output: '
  test_words.my_each_with_index do |element, index|
    puts "Index: #{index}, Element:#{element}"
  end
puts 'test_hash.my_each_with_index do |element, index|
puts "Index: #{index}, Element: #{element}"
end output: '
  test_hash.my_each_with_index do |element, index|
    puts "Index: #{index}, Element: #{element}"
  end
puts
puts
# Tests for #my_select
puts 'test_array.my_select(&:odd?) output: '
p test_array.my_select(&:odd?)
puts 'test_words.my_select() output: '
p (test_words.my_select { |words| words.length >= 4 })
puts 'test_hash.my_select { |key, value| value == 2 } output: '
p(test_hash.my_select { |_key, value| value == 2 })
puts
puts
# Tests for #my_all?
puts 'test_words.my_all? { |word| word.length >= 3 } output: '
p(test_words.my_all? { |word| word.length >= 3 })
puts 'test_words.my_all? { |word| word.length >= 3 } output: '
p(test_words.my_all? { |word| word.length >= 4 })
puts 'test_array.all?(3) output: '
p(test_array.all?(3))
puts '[].my_all? output: '
p([].my_all?)
puts
puts
# Tests for #my_any?
puts 'test_words.my_any? { |word| word.length >= 3 } output: '
p(test_words.my_any? { |word| word.length >= 3 })
puts 'test_words.my_any? { |word| word.length >= 7 } output: '
p(test_words.my_any? { |word| word.length >= 7 })
puts '[nil, true, 99].my_any?(Integer) output: '
p([nil, true, 99].my_any?(Integer))
puts "test_words.my_any?(\'cat\') output: "
p(test_words.my_any?('cat'))
puts "test_words.my_any?(\'cat\') output: "
p(test_words.my_any?('tree'))
puts
puts
# Tests for #my_none?
puts 'test_words.my_none? { |word| word.length == 2} output: '
p(test_words.my_none? { |word| word.length == 2 })
puts 'test_words.my_none? { |word| word.length >= 4 } output: '
p(test_words.my_none? { |word| word.length >= 4 })
puts 'test_words.my_none?(/z/) output: '
p(test_words.my_none?(/z/))
puts '[nil, false, true].my_none? output: '
p([nil, false, true].my_none?)
puts 'test_words.my_none?(5) output: '
p(test_words.my_none?(5))
puts
puts
# Tests for #my_count?
puts 'test_array.my_count(5) output: '
p test_array.my_count(5)
puts 'test_array.my_count { |n| n <= 6 }'
p(test_array.my_count { |n| n <= 6 })
puts 'test_hash.my_count { |key, value| value.odd? } output: '
p(test_hash.my_count { |_key, value| value.even? })
puts
puts
# Tests for #my_map
puts 'test_array.my_map { |n| n * 5 } output: '
p(test_array.my_map { |n| n * 5 })
puts 'test_hash.my_map { |key, value| [key, value]} output: '
p(test_hash.my_map { |key, value| [key, value] })
puts 'test_words.map { |words| words.upcase } output: '
p(test_words.map(&:upcase))
puts
puts
# Tests for #my_inject
puts 'test_array.my_inject { |sum, n| sum + n } output: '
p(test_array.my_inject { |sum, n| sum + n })
puts 'test_array.my_inject { |sum, n| sum + n } output: '
p(test_array.my_inject { |sum| sum * 3 })
puts 'longest_word = test_words.inject do |memo, word|
  memo.length > word.length ? memo : word
end output: '
longest_word = test_words.inject do |memo, word|
  memo.length > word.length ? memo : word
end
p longest_word
