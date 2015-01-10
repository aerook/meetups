require './item.rb'

class Conjured < Item
  attr_accessor :name, :quality, :sell_in
  def initialize(sell_in, quality)
    super("Conjured Mana Cake", sell_in, quality)
  end

  def update_item
    update_quality
    update_sell_in
  end

  private

  def update_quality
    return if self.quality == 0
    if self.quality > 2
      self.quality -= 2
    else
      self.quality -= 1
    end
  end

  def update_sell_in
    return if self.sell_in == 0
    self.sell_in -= 1
  end
end
