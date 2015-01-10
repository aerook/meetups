require './item.rb'

class AgedBrie < Item
  def initialize(sell_in, quality)
    super("Aged Brie", sell_in, quality)
  end

  def update_item
    update_quality
    update_sell_in
  end

  private

  def update_quality
    return if self.quality >= 50

    self.quality += 1
  end

  def update_sell_in
    unless self.sell_in == 0
      self.sell_in = self.sell_in - 1
    end
  end
end
