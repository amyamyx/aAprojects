class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    num = 0
    self.each_with_index do |el, idx|
      num += (el.to_s.length + idx * 30).hash
    end

    num.hash
  end
end

class String
  def hash
    letters = ("a".."z").to_a + ("A".."Z").to_a
   
    num = 0

    self.each_char.with_index do |ch, idx|
      num += (letters.index(ch) + idx.hash).hash
    end

    num.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    num = 0

    self.each do |k, v|
      num += (k.hash + v.hash).hash
    end

    num.hash
  end
end
