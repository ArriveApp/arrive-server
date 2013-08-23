require 'spec_helper'

describe UniquePinGenerator do
  describe '#next' do
    it 'returns a pin of the correct length' do
      pin_generator = UniquePinGenerator.new([], 4)

      next_pin = pin_generator.next

      expect(next_pin.size).to eq(4)
    end

    it 'does not return a pin that has already been used' do
      pin_generator = UniquePinGenerator.new(['1234', '5678'], 4)

      pin_generator.stub(:random_from).and_return('1234', 'abcd')

      next_pin = pin_generator.next

      expect(next_pin).to eq('abcd')
    end
  end
end