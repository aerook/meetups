require './item.rb'

class RegularItem < Item

  attr_accessor :name, :sell_in, :quality

  def update_item
    update_quality
    update_sell_in
  end

  private

  def update_quality
    unless self.quality == 0
      if self.sell_in <= 0 && self.quality > 1
        self.quality -= 2
      else
        self.quality -= 1
      end
    end
  end

  def update_sell_in
    unless self.sell_in == 0
      self.sell_in = self.sell_in - 1
    end
  end
end
