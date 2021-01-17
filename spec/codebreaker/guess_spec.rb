# frozen_string_literal: true

RSpec.describe Codebreaker::Guess do
  context 'when guess validation' do
    let(:non_number) { '#$jhs' }
    let(:empty) { '' }
    let(:negative) { -1234 }

    it 'have numbers' do
      expect(described_class.new(non_number).valid?).to be false
    end

    it 'not empty' do
      expect(described_class.new(empty).valid?).to be false
    end

    it 'is positive' do
      expect(described_class.new(negative).valid?).to be false
    end

    context 'with length' do
      let(:max_output_range) { 12_345 }
      let(:below_range) { 123 }

      it 'not valid max output range' do
        expect(described_class.new(max_output_range).valid?).to be false
      end

      it 'not valid min output range' do
        expect(described_class.new(below_range).valid?).to be false
      end
    end

    context 'with range' do
      let(:valid_range) { 1236 }
      let(:not_valid_range) { 8237 }

      it 'valid' do
        expect(described_class.new(valid_range).valid?).to be true
      end

      it 'not valid' do
        expect(described_class.new(not_valid_range).valid?).to be false
      end
    end
  end
end
