require './gilded_rose.rb'
require './item.rb'
require "rspec"
require 'pry'

describe GildedRose do

  subject(:rose) { described_class.new }

  describe "#items" do
    it "has a sell_in date" do
      result = subject.items.all? { |item| item.respond_to?(:sell_in) }
      expect(result).to eq(true)
    end

    it "has quality" do
      result = subject.items.all? { |item| item.respond_to?(:quality) }
      expect(result).to eq(true)
    end
  end

  describe "#update_quality" do

    context "when item is normal" do
      let(:item) { first_of(RegularItem) }
      let(:quality) { item.quality }
      let(:sell_in) { item.sell_in }

      it "lowers the quality by 1" do
        expect { rose.update_quality }.to change(item, :quality).by(-1)
      end

      it "lowers the sell_in date by 1" do
        expect { rose.update_quality }.to change(item, :sell_in).by(-1)
      end

      context "when item is past sell_in date" do
        before do
          item.sell_in = 0
        end

        it "lowers quality 2x as fast" do
          expect { rose.update_quality }.to change(item, :quality).by(-2)
        end
      end

      context "when quality is already 0" do
        before { item.quality = 0 }

        it "does not go below 0" do
          expect { rose.update_quality }.not_to change(item, :quality)
        end
      end
    end

    context "when item is aged bree" do
      let(:item) { first_of(AgedBrie) }

      it "gets better with time" do
        expect { rose.update_quality }.to change(item, :quality).by(1)
      end

      context "when quality is 50" do
        before { item.quality = 50 }

        it "does not increase further" do
          expect { rose.update_quality }.not_to change(item, :quality)
        end
      end

      context "when item is sulfuras" do
        let(:item) { first_of(Sulfuras) }

        it "does not change quality" do
          expect { rose.update_quality }.not_to change(item, :quality)
        end

        it "does not change quality" do
          expect { rose.update_quality }.not_to change(item, :sell_in)
        end
      end

    end

    context "when item is 'backstage passes'" do
      let(:item) { first_of(Ticket) }
      before do
        item.quality = 20
      end

      context "when sell_in is greater than 10" do
        before { item.sell_in = 11 }

        it 'behaves normally' do
          rose.update_quality
          expect(item.quality).to eq(21)
          expect(item.sell_in).to eq(10)
        end
      end

      context "when sell_in is between 9 and 6" do
        before { item.sell_in = 8 }
        it "increases quality by 2" do
          expect { rose.update_quality }.to change(item, :quality).by(2)
        end
      end

      context "when sell_in is 5 or less" do
        before { item.sell_in = 5 }
        it "increases quality by 3" do
          expect { rose.update_quality }.to change(item, :quality).by(3)
        end
      end

      context "when concert is over" do
        before { item.sell_in = 0 }
        it "loses all quality" do
          rose.update_quality
          expect(item.quality).to eq(0)
        end
      end
    end

    context "when item is a Conjured item" do
      let(:item) { first_of(Conjured) }
      before { item.quality = 20 }
      it "degrades 2x as fast" do
        expect { rose.update_quality }.to change(item, :quality).by(-2)
      end
    end
  end
end

def first_of(klass)
  rose.items.select { |item| item.is_a?(klass) }.first
end
