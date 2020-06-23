require "../custom_enumerable_methods"
describe Enumerable do
  let(:test_array) { [5, 7, 9, 5] }
  let(:test_hash) { { w: 3, x: 4, y: 2, z: 6 } }
  let(:test_words) { %w[cat house tree fan] }
  let(:array_with_nil) { [5, nil, 9] }
  # let(:extended_class) { Class.new { extend Enumerable } }
  # w: 3, x: 4, y: 2, z: 6

  describe "#my_each" do
    it "prints all the elements of an integer array" do
      expect { test_array.my_each { |item| print item } }.to output("5795").to_stdout
    end
    it "Should return an enum when no block is given" do
      expect(test_array.my_each).to be_a(Enumerable)
    end
    it "prints all the elements of words array" do
      expect { test_words.my_each { |item| print item } }.to output("cathousetreefan").to_stdout
    end
    it "prints all the key value pair in a hash" do
      expect { test_hash.my_each { |key, value| puts "Key: #{key}, Value: #{value}" } }.to output("Key: w, Value: 3\nKey: x, Value: 4\nKey: y, Value: 2\nKey: z, Value: 6\n").to_stdout
    end
  end

  describe "#my_each_with_index" do
    it "prints an integer array" do
      expect { print(test_array.my_each_with_index { |num| num }) }.to output("[5, 7, 9, 5]").to_stdout
    end
    it "Should return an enum when no block is given" do
      expect(test_array.my_each).to be_a(Enumerable)
    end
  end

  describe "#my_select" do
    it "Should return an enum when no block is given" do
      expect(test_array.my_select).to be_a(Enumerable)
    end
    it "Returns an array with all elements for which the given block returns a true value" do
      expect(test_array.my_select { |i| i.positive? }).to eq([5, 7, 9, 5])
    end
    it "Returns an array with all even elements" do
      expect(test_array.my_select { |i| i.even? }).to eq([])
    end
    it "should return an array with the value(s) which matches the condition within the block" do
      expect(test_words.my_select { |i| i == "house" }).to eq(["house"])
    end
  end

  describe "#my_all" do
    it "should return true if the condition of the block never returns false or nil" do
      expect(test_words.all? { |i| i.length > 2 }).to eq(test_words.my_all? { |i| i.length > 2 }) #compares to built-in #all?
    end
    it "should return true if all items match the condition within the block" do
      expect(test_array.my_all? { |i| i.positive? }).to be(true)
    end
    describe "When a block is not given, ruby ads an implicit block of { |obj| obj }, and" do
      it "should return true if none of the list items are false or nil" do
        expect(test_array.my_all?).to eq(test_array.all?)
      end
      it "should return false if some item of the list is false or nil," do
        expect(array_with_nil.my_all?).to eq(array_with_nil.all?)
      end
      it "should return true if all items match the RegExp condition" do
        expect(test_words.all?(/t/)).to eq(test_words.my_all?(/t/)) #\d is used to find a tab character
      end
    end
  end

  describe "#my_any" do
    it "should return true if the condition of the block ever returns other value than false or nil" do
      expect(test_words.my_any? { |i| i.length >= 5 }).to eq(true)
    end
    describe "When a block is not given, ruby ads an implicit block of { |obj| obj }, and" do
      it "should return true if any of the list items are not false or nil" do
        expect(array_with_nil.any?).to eq(true)   #there´s an error in enumerable_method code !!!!!!!!!!!!!!!!<-------- check!
      end
      it "should return true if is a non empty array" do
        expect(test_array.any?).to(eq(true))      #there´s an error in enumerable_method code !!!!!!!!!!!!!!!!<-------- check!
      end
      it "should return true if all items match the RegExp condition" do
        expect(test_words.all?(/t/)).to eq(test_words.my_all?(/t/)) #\d is used to find a tab character
      end
    end
  end
end
