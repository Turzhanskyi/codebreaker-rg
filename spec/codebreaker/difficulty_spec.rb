# frozen_string_literal: true

RSpec.describe Codebreaker::Difficulty do
  it 'initialize' do
    name = described_class::LEVELS.keys.sample
    difficulty = described_class.new(name)
    expect(difficulty.name).to eql(described_class::LEVELS[name][:name])
  end

  it 'not valid difficulty name' do
    difficulty = described_class.new(:custom)
    expect(difficulty.valid?).to be false
  end
end
