module Enumerable
def my_each 
  return to_enum unless block_given?
  x = 0
  self_class = self.class
  array = if self_class == Array
            self
          elsif self_class == Range
            to_a
          end 
  while x < array.length
       if self_class == Hash
          yield array[x], array[x+1]
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
  self_class = self.class

  self_class == Array ? [] : {}
    if self_class == Array
        my_each do |x|
        self_class.push(x) if yield(x)
        end
    else
        my_each do |key, value|
        self_class[key]  =  value) if yield (key, value)
        end
    end
  self_class
end







end

 array = [1, 2, 3, 4]
 aar = 1..5
 aar.each_with_index {|value, idx| puts "#{idx + 1} #{ value}"}
 puts
 aar.my_each_with_index {|value, idx| puts "#{idx + 1} #{ value}" }
 puts

