# O(n!) factorial time
# O(n!) factorial space
def first_anagram?(str1, str2)
  anagrams = str1.chars.permutation.map { |set| set.join }
  anagrams.include?(str2)
end

# O(n^2) quadratic time
# O(n) linear space (str2_ary)
def second_anagram?(str1, str2)
  str2_ary = str2.chars

  str1.each_char do |ch|
    idx = str2_ary.index(ch)
    return false if idx.nil?
    str2_ary.delete_at(idx)
  end

  str2_ary.empty?
end

# O(n log n) linearithmic time (built in #sort is using quicksort algorithm)
# O(n) linear space
def third_anagram?(str1, str2)
  str1.chars.sort == str2.chars.sort
end


# O(n) linear time
# O(1) constant space (maximum of 26 letters so it's constant)
def fourth_anagram?(str1, str2)
  hash = Hash.new(0)
  str1.each_char { |ch| hash[ch] += 1 }
  str2.each_char { |ch| hash[ch] -= 1 }
  hash.all? { |k, v| v == 0 }
end