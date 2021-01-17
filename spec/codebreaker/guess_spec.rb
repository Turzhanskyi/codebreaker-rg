# frozen_string_literal: true

RSpec.describe Codebreaker::Guess do
  context 'when guess validation' do
    it 'have numbers' do
      expect(described_class.new('#$jhs').valid?).to be false
    end

    it 'not empty' do
      expect(described_class.new('').valid?).to be false
    end

    it 'is positive' do
      expect(described_class.new(-1234).valid?).to be false
    end

    context 'with length' do
      it 'not valid max output range' do
        expect(described_class.new(12_345).valid?).to be false
      end

      it 'not valid min output range' do
        expect(described_class.new(123).valid?).to be false
      end
    end

    context 'with range' do
      it 'valid' do
        expect(described_class.new(1236).valid?).to be true
      end

      it 'not valid' do
        expect(described_class.new(1237).valid?).to be false
      end
    end
  end
end
