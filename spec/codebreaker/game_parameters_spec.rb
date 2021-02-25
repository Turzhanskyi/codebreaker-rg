# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game_levels) { { easy: :easy, medium: :medium, hell: :hell } }
  let(:difficulty) { Codebreaker::Difficulty.new(game_levels.keys.sample) }
  let(:game) { described_class.new(Codebreaker::User.new(Faker::Name.first_name), difficulty) }

  context 'with difficulty' do
    it 'hints' do
      expect(game.hints_total).to eql difficulty.difficulty_level[:hints]
    end

    it 'attempts' do
      expect(game.attempts_total).to eql difficulty.difficulty_level[:attempts]
    end
  end
end
