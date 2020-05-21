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
  my_enumerable = self.class == Array ? [] : {}
     if my_enumerable.class == Array
         my_each do |n|
          my_enumerable.push(n) if yield(n)
         end
     else
         my_each do |key, value|
          my_enumerable[key]  =  value if yield(key, value)
         end
     end
    my_enumerable
end

def my_all?(my_parameter = nil)
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
  




end

