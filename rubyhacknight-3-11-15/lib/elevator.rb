class Elevator

  def initialize
    @current_floor = 1
    @target_floor = nil
    @doors = :closed
    @stops = []
  end
  attr_accessor :current_floor, :target_floor, :doors, :stops

  def up
    @current_floor += 1
  end

  def down
    @current_floor -= 1
  end

  def go_to_floor(target_floor)
    raise ArgumentError, "Floor numbers have to be numbers, duh." unless target_floor.is_a?(Integer)
    @target_floor = target_floor
  end

  def doors_closed?
    @doors == :closed
  end

  def doors_open?
    @doors == :open
  end

  def open_doors
    @doors = :open
  end

  def close_doors
    @doors = :closed
  end

  def direction
    return nil unless @target_floor
    diff = @current_floor - @target_floor
    return nil if diff == 0
    diff < 0 ? :ascending : :descending
  end

  def stop_at(floor)
    @stops << floor
  end

  def passing_floor?(floor_number, dir)
    return false unless direction == dir
    direction == :ascending ? current_floor <= floor_number : current_floor >= floor_number
  end

  def tick
    if target_floor == current_floor
      open_doors
      @target_floor = nil
    elsif stops.include? current_floor
      open_doors
      stops.delete current_floor
    elsif doors_open?
      close_doors
    elsif target_floor
      move_in_target_direction
    end
  end

  def move_in_target_direction
    case direction
    when :ascending
      up
    when :descending
      down
    end
  end
end
