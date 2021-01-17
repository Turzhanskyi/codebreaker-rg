# frozen_string_literal: true

RSpec.describe Codebreaker::User do
  let(:user) { described_class.new("#{Faker::Name.first_name} #{Faker::Name.last_name}") }

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

  context 'with name validation' do
    it 'name should be string' do
      names = ['1111', 1111, '#@#$']
      names.each do |name|
        user = described_class.new(name)
        expect(user.valid?).to be false
      end
    end

    it 'name cannot be blank' do
      user = described_class.new('')
      expect(user.valid?).to be false
    end

    it 'min allowed name length' do
      user = described_class.new('fo')
      expect(user.valid?).to be false
    end

    it 'max allowed name length' do
      user = described_class.new('fooopoooooooooooooooo')
      expect(user.valid?).to be false
    end
  end

  context 'when valid user edge cases' do
    it 'creates user with min allowed length' do
      user = described_class.new('foo')
      expect(user.valid?).to be true
    end

    it 'creates user with max allowed length' do
      user = described_class.new('f' * described_class::MAX_NAME_LENGTH)
      expect(user.valid?).to be true
    end
  end
end
