require 'spec_helper'

describe Building do
  let(:number_of_floors) { 20 }
  let(:number_of_elevators) { 2 }
  let(:basement) { false }
  subject(:building) { described_class.new(number_of_floors, number_of_elevators, basement) }

  describe "#elevators" do
    it "has the correct number of elevators" do
      expect(subject.elevators.count).to eq(number_of_elevators)
    end
  end

end
