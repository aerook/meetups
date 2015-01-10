require './item.rb'

class Sulfuras < Item

  attr_accessor :name, :sell_in, :quality

  def initialize(sell_in, quality)
    super("Sulfuras, Hand of Ragnaros", sell_in, quality)
  end

  def update_item
  end
end
