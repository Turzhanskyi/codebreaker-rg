# frozen_string_literal: true

RSpec.describe Codebreaker::Difficulty do
  subject(:difficulty) { described_class }

  let(:correct_difficulty) { described_class::LEVELS.keys.sample }
  let(:incorrect_difficulty) { :custom }

  it 'valid with correct difficulty' do
    expect(difficulty.new(correct_difficulty).name).to eql(correct_difficulty)
  end

  it 'not valid with incorrect difficulty' do
    expect(difficulty.new(incorrect_difficulty).valid?).to be false
  end
end
