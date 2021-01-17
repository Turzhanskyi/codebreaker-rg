# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:game_levels) { { easy: :easy, medium: :medium, hell: :hell } }
  let(:difficulty) { Codebreaker::Difficulty.new(game_levels.keys.sample) }
  let(:game) { described_class.new(Codebreaker::User.new(Faker::Name.first_name), difficulty) }

  context 'with difficulty' do
    it 'hints' do
      expect(game.hints_total).to eql difficulty.level[:hints]
    end

    it 'attempts' do
      expect(game.attempts_total).to eql difficulty.level[:attempts]
    end
  end

  context 'with attempts' do
    it 'attempt changed' do
      game.instance_variable_set(:@attempts_used, 0)
      expect { game.attempt }.to change(game, :attempts_used).from(0).to(1)
    end
  end

  context 'when hints' do
    it 'hints used' do
      game.instance_variable_set(:@hints_used, 1)
      expect { game.increment_hint }.to change(game, :hints_used).from(1).to(2)
    end
  end
end
