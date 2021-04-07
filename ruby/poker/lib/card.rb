class Card
  attr_reader :type, :num
  def initialize(type, num)
    @type = type
    @num = num
  end
end