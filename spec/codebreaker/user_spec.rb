# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  let(:user) { described_class.new("#{Faker::Name.first_name} #{Faker::Name.last_name}") }

  context 'with name validation' do
    let(:above_max_length_name) { 'f' * (described_class::NAME_LENGTH_RANGE.max + 1) }
    let(:below_min_length_name) { 'f' * (described_class::NAME_LENGTH_RANGE.min - 1) }
    let(:non_string_names) { ['1111', 1111, '#@#$'] }
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

  context 'with difficulty' do
    let(:name) { Codebreaker::Difficulty::LEVELS.keys.sample }

    before do
      user.add_difficulty(Codebreaker::Difficulty.new(name))
    end

    it 'hints' do
      expect(user.hints_total).to eql Codebreaker::Difficulty::LEVELS[name][:hints]
    end

    it 'attempts' do
      expect(user.attempts_total).to eql Codebreaker::Difficulty::LEVELS[name][:attempts]
    end
  end

  context 'with attempts' do
    it 'attempt changed' do
      user.instance_variable_set(:@attempts_used, 0)
      expect { user.attempt! }.to change(user, :attempts_used).from(0).to(1)
    end

    it 'reset' do
      allow(user).to receive(:attempts_total).and_return(15)
      user.reset!
      expect(user.attempts_used).to be_zero
    end
  end

  context 'when hints' do
    it 'hints used' do
      user.instance_variable_set(:@hints_used, 1)
      expect { user.hint! }.to change(user, :hints_used).from(1).to(2)
    end

    it 'hints reset' do
      name = Codebreaker::Difficulty::LEVELS.keys.sample
      hints = Codebreaker::Difficulty::LEVELS[name][:hints]
      user.instance_variable_set(:@hints_used, hints)
      expect { user.reset! }.to change(user, :hints_used).from(hints).to(0)
    end
  end
end
