require "../custom_enumerable_methods"
describe  Enumerable do
let(:test_array) { [5, 7, 9, 5] }
let(:test_hash) { { w: 3, x: 4} }
let(:test_words) { %w[cat house tree fan] }
# let(:extended_class) { Class.new { extend Enumerable } }
# w: 3, x: 4, y: 2, z: 6 

    describe "#my_each" do
      it "prints all the elements of an integer array" do
        expect{test_array.my_each { |item| print item } }.to output('5795').to_stdout
      end
      it "Should return an enum when no block is given" do
         expect(test_array.my_each).to be_a(Enumerable)
      end
      it "prints all the elements of words array" do
        expect{test_words.my_each { |item| print item } }.to output('cathousetreefan').to_stdout
      end
      it "prints all the elements of words array" do
        expect{test_hash.my_each { |key, value|  puts "Key: #{key}, Value: #{value}" } }.to output('key:' 'w', 'value:' "#{value}" \n 'key:' 'x', 'value':"#{value}").to_stdout
      end
    end
  end