require 'spec_helper'

describe Floor do
  let(:building) { Building.new(5, 1) }
  subject(:floor) { described_class.new(3, building) }

  describe "#press_up_button" do
    it "requests an elevator moving up" do
      expect(subject).to receive(:request_elevator).with(:up)
      subject.press_up_button
    end
  end

  describe "#press_down_button" do
    it "requests an elevator moving down" do
      expect(subject).to receive(:request_elevator).with(:down)
      subject.press_down_button
    end
  end
end
