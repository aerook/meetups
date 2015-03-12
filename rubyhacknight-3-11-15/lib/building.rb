require_relative "elevator"
require_relative "floor"

class Building

  def tick
    assign_open_requests
    elevators.each(&:tick)
  end

  def initialize(number_of_floors, number_of_elevators, basement = false)
    # number of floors does not include basement
    #
    @elevators = []
    @floors = []
    @top_floor = number_of_floors

    number_of_elevators.times { @elevators << Elevator.new }
    number_of_floors.times { |number| @floors << Floor.new(number + 1, self) }
  end
  attr_reader :elevators, :floors

  def request_elevator(floor, direction)
    return nil unless valid_request?(floor, direction)
    request = [floor.floor_number, direction]
    requests.delete_if { |request| request[0] == floor.floor_number }
    requests << request
  end

  def requests
    @requests ||= []
  end

  def assign_open_requests
    requests.each do |floor_num, direction|
      request_filled = false
      require 'pry'; binding.pry
      if elevator_on_floor = elevator_on_floor?(floor_num)
        if elevator_on_floor.direction == direction || elevator_on_floor.direction.nil?
          elevator_on_floor.go_to_floor floor_num
          request_filled = true
        end
      else
        request_filled = assign_elevator(floor_num, direction)
      end
      delete_request(floor_num) if request_filled
    end
  end

  private

  def assign_elevator
    if elevator_en_route = elevators_moving_to?(floor_num, direction)
      elevator_en_route.stop_at(floor_num)
      return true
    elsif stationary_elevators.any?
      stationary_elevators.first.go_to_floor(floor_num)
      return true
    else
      false
    end
  end

  def delete_request(floor_num)
    requests.delete_if { |num, dir| num == floor_num }
  end

  def elevator_on_floor?(number)
    elevators.select { |elevator| elevator.current_floor == number }.first
  end

  def elevators_moving_to?(floor_num, direction)
    elevators.select do |elevator|
      elevator.passing_floor?(floor_num, direction)
    end.first
  end

  def stationary_elevators
    elevators.select { |ele| ele.direction.nil? }
  end

  def valid_request?(floor, direction)
    require 'pry'; binding.pry
    if floor.floor_number == @top_floor && direction == :up
      return false
    end

    if floor.floor_number == 1 && direction == :down
      return false
    end
    true
  end
end
