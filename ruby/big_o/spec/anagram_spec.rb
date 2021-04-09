require "anagram"

describe "anagram versions" do
  let(:combo1) { ["gizmo", "sally"] }
  let(:combo2) { ["elvis", "lives"] }
  let(:combo3) { ["asdfjkl;zxcvm,./qweruiop", ";lkjfdsa/.,mvcxzpoiurewq"] }
  it "#first_anagram?" do
    expect(first_anagram?(*combo1)).to be(false)  
    expect(first_anagram?(*combo2)).to be(true)  
    # expect(first_anagram?(*combo3)).to be(true)  
  end
  
  it "#second_anagram?" do
    expect(second_anagram?(*combo1)).to be(false)  
    expect(second_anagram?(*combo2)).to be(true)  
    expect(second_anagram?(*combo3)).to be(true)  
  end

  it "#third_anagram?" do
    expect(third_anagram?(*combo1)).to be(false)  
    expect(third_anagram?(*combo2)).to be(true)  
    expect(third_anagram?(*combo3)).to be(true)    
  end

  it "#fourth_anagram?" do
    expect(fourth_anagram?(*combo1)).to be(false)  
    expect(fourth_anagram?(*combo2)).to be(true)  
    expect(fourth_anagram?(*combo3)).to be(true)  
  end
end