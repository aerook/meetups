describe Elevator do
  subject(:elevator) { described_class.new }

  describe "#up" do
    it "moves the elevator up one floor" do
      expect { subject.up }.to change { subject.current_floor }.by(1)
    end
  end

  describe "#down" do
    it "moves the elevator down one floor" do
      expect { subject.down }.to change { subject.current_floor }.by(-1)
    end
  end

  describe "#go_to_floor" do
    it "sets the target floor for the elevator" do
      subject.go_to_floor(4)
      expect(subject.target_floor).to eq(4)
    end
  end

  describe "#open_doors" do
    it "opens the doors" do
      subject.open_doors
      expect(subject).to be_doors_open
      expect(subject).not_to be_doors_closed
    end
  end

  describe "#close_doors" do
    it "closes the doors" do
      subject.close_doors
      expect(subject).to be_doors_closed
      expect(subject).not_to be_doors_open
    end
  end

  describe "#direction" do
    context "when the elevator is not moving" do
      it "returns nil" do
        expect(subject.direction).to be_nil
      end
    end

    context "when the target floor is higher than the current floor" do
      before do
        subject.current_floor = 1
        subject.target_floor = 5
      end

      it "returns ascending" do
        expect(subject.direction).to eq(:ascending)
      end
    end

    context "when the target floor is lower than the current floor" do
      before do
        subject.current_floor = 5
        subject.target_floor = 1
      end

      it "returns descending" do
        expect(subject.direction).to eq(:descending)
      end
    end

    context "when elevator has arrived at its destination" do
      before do
        subject.current_floor = 3
        subject.target_floor =3
      end

      it "returns nil" do
        expect(subject.direction).to be_nil
      end
    end
  end
end

