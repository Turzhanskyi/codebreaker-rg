# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  context 'with name validation' do
    let(:above_max_length_name) { 'f' * (described_class::NAME_LENGTH_RANGE.max + 1) }
    let(:below_min_length_name) { 'f' * (described_class::NAME_LENGTH_RANGE.min - 1) }
    let(:non_string_names) { ['1111@', 1111, '#@#$'] }
    let(:empty_name) { '' }

    it 'name should be string' do
      non_string_names.each do |name|
        user = described_class.new(name)
        expect(user.valid?).to be false
      end
    end

    it 'name cannot be blank' do
      user = described_class.new(empty_name)
      expect(user.valid?).to be false
    end

    it 'min allowed name length' do
      user = described_class.new(below_min_length_name)
      expect(user.valid?).to be false
    end

    it 'max allowed name length' do
      user = described_class.new(above_max_length_name)
      expect(user.valid?).to be false
    end
  end

  context 'when valid user edge cases' do
    let(:min_length_name) { 'f' * described_class::NAME_LENGTH_RANGE.min }
    let(:max_length_name) { 'f' * described_class::NAME_LENGTH_RANGE.max }

    it 'creates user with min allowed length' do
      user = described_class.new(min_length_name)
      expect(user.valid?).to be true
    end

    it 'creates user with max allowed length' do
      user = described_class.new(max_length_name)
      expect(user.valid?).to be true
    end
  end
end
