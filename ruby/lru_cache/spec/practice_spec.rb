require "practice"

describe LRUCache do
  subject(:johnny_cache) { LRUCache.new(4) }

  describe "#initialize" do
    it "takes an integer as an argument" do
      expect { LRUCache.new }.to raise_error(ArgumentError)
      expect { LRUCache.new("four") }.to raise_error(TypeError)
    end

    it "set @size to the specified number" do
      expect(johnny_cache.size).to eq(4)
    end

    it "sets the @cache as an empty array" do
      expect(johnny_cache.cache).to be_empty
    end
  end

  describe "#count" do
    it "returns the number of items in the cache" do
      expect(johnny_cache.count).to eq(0)
      johnny_cache.cache << 5
      johnny_cache.cache << 3
      expect(johnny_cache.count).to eq(2)
    end
  end

  describe "#add" do
    before(:each) {
      johnny_cache.add("I walk the line")
      johnny_cache.add(5)
      johnny_cache.add([1, 2, 3])
    }

    context "when the cache is not full" do
      it "inserts items in @cache" do
        expect(johnny_cache.cache).to eq(["I walk the line", 5, [1, 2, 3]])
      end
    end

    context "when the cache is full" do
      before(:each) do 
        johnny_cache.add(4)
        johnny_cache.add("wut wut")
      end
      
      it "removed the least recently used item in the cache" do
        expect(johnny_cache.include?("I walk the line")).to be(false)
      end

      it "adds to the most recent position" do
        expect(johnny_cache.cache[-1]).to eq("wut wut")
      end
    end

    context "when the new item exists" do
      before(:each) { johnny_cache.add(5) }

      it "does not add twice" do
        expect(johnny_cache.cache.count(5)).to eq(1)
      end

      it "add the item to the most recent position of the cache" do 
        expect(johnny_cache.cache).to eq(["I walk the line", [1, 2, 3], 5])
      end
    end
  end

  describe "#show" do 
    before(:each) {
      johnny_cache.add("I walk the line")
      johnny_cache.add(5)
      johnny_cache.add([1, 2, 3])
      johnny_cache.add(5)
      johnny_cache.add(-5)
      johnny_cache.add({a: 1, b: 2, c: 3})
      johnny_cache.add([1,2,3,4])
      johnny_cache.add("I walk the line")
      johnny_cache.add(:ring_of_fire)
      johnny_cache.add("I walk the line")
      johnny_cache.add({a: 1, b: 2, c: 3})
    }

    it "prints the cache" do
      expect { johnny_cache.show }.to output('[[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]').to_stdout
    end
  end
end