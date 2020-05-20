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








end

 array = [1, 2, 3, 4]
 aar = 1..5
 aar.each {|n| print n }
 puts
 aar.my_each {|n| print n }
 puts

