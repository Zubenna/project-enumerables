require "../custom_enumerable_methods"
describe Enumerable do
  let(:test_array) { [5, 7, 9, 5] }
  let(:test_hash) { { w: 3, x: 4, y: 2, z: 6 } }
  let(:test_words) { %w[cat house tree fan] }
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
      expect(test_array.my_select { |i| i.positive? }).to eql([5, 7, 9, 5])
    end
    it "Returns an array with all even elements" do
      expect(test_array.my_select { |i| i.even? }).to eq([])
    end
    it "should return an array with the value(s) which matches the condition on the block" do
      expect(test_words.my_select { |i| i == "house" }).to eq(["house"])
  end
end
