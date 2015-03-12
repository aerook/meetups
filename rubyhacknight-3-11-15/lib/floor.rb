class Floor
  def initialize(floor_number, building)
    @floor_number = floor_number
    @building = building
  end
  attr_reader :floor_number

  def press_up_button
    request_elevator(:up)
  end

  def press_down_button
    request_elevator(:down)
  end

  private

  def request_elevator(direction)
    @building.request_elevator(self, direction)
  end
end
