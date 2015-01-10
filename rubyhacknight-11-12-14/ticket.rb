require './item.rb'

class Ticket < Item
  attr_accessor :name, :sell_in, :quality
  def initialize(sell_in, quality)
    super("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)
  end

  def update_item
    update_quality
    update_sell_in
  end

  private

  def update_quality
    if self.sell_in > 10
      self.quality += 1
    elsif self.sell_in >= 6
      self.quality += 2
    elsif self.sell_in > 0
      self.quality += 3
    else
      self.quality = 0
    end
  end

  def update_sell_in
    self.sell_in -= 1
  end
end
