# frozen_string_literal: true

RSpec.describe Codebreaker::Difficulty do
  subject(:difficulty) { described_class }

  let(:game_levels) { { easy: :easy, medium: :medium, hell: :hell } }
  let(:correct_difficulty_name) { game_levels.keys.sample }
  let(:incorrect_difficulty_names) { [:custom, nil] }

  it 'valid with correct difficulty' do
    expect(difficulty.new(correct_difficulty_name)
                     .difficulty_level[:name]).to eql(correct_difficulty_name)
  end

  it 'not valid with incorrect difficulty' do
    incorrect_difficulty_names.each do |name|
      expect(difficulty.new(name).valid?).to be false
    end
  end
end
