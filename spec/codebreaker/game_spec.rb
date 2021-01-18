# frozen_string_literal: true

RSpec.describe Codebreaker::Game do
  let(:name) { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
  let(:game_levels) { { easy: :easy, medium: :medium, hell: :hell } }
  let(:difficulty) { Codebreaker::Difficulty.new(game_levels.keys.sample) }
  let(:game) { described_class.new(Codebreaker::User.new(name), difficulty) }

  it 'has user with name' do
    expect(game.user.name).to eql name
  end

  context 'when lost game' do
    let(:secret_code) { '2442' }

    before do
      game.instance_variable_set(:@secret_code, secret_code)
    end

    it 'has no attempts available' do
      (game.difficulty[:attempts] + 1).times { game.compare('1111') }
      expect(game.attempts_available?).to be false
    end
  end

  it 'hints' do
    expect(game.hint).to be_truthy
  end

  it 'no hints' do
    (game.difficulty[:hints] + 1).times { game.hint }
    expect(game.hint).to be_falsey
  end

  context 'with RubyGarage Codebreaker examples matrix' do
    [
      [[6, 5, 4, 1], [6, 5, 4, 1], [PLUS, PLUS, PLUS, PLUS]],
      [[1, 2, 2, 1], [2, 1, 1, 2], [MINUS, MINUS, MINUS, MINUS]],
      [[6, 2, 3, 5], [2, 3, 6, 5], [PLUS, MINUS, MINUS, MINUS]],
      [[1, 2, 3, 4], [4, 3, 2, 1], [MINUS, MINUS, MINUS, MINUS]],
      [[1, 2, 3, 4], [1, 2, 3, 5], [PLUS, PLUS, PLUS]],
      [[1, 2, 3, 4], [5, 4, 3, 1], [PLUS, MINUS, MINUS]],
      [[1, 2, 3, 4], [1, 5, 2, 4], [PLUS, PLUS, MINUS]],
      [[1, 2, 3, 4], [4, 3, 2, 6], [MINUS, MINUS, MINUS]],
      [[1, 2, 3, 4], [3, 5, 2, 5], [MINUS, MINUS]],
      [[1, 2, 3, 4], [5, 6, 1, 2], [MINUS, MINUS]],
      [[5, 5, 6, 6], [5, 6, 0, 0], [PLUS, MINUS]],
      [[1, 2, 3, 4], [6, 2, 5, 4], [PLUS, PLUS]],
      [[1, 2, 3, 1], [1, 1, 1, 1], [PLUS, PLUS]],
      [[1, 1, 1, 5], [1, 2, 3, 1], [PLUS, MINUS]],
      [[1, 2, 3, 4], [4, 2, 5, 5], [PLUS, MINUS]],
      [[1, 2, 3, 4], [5, 6, 3, 5], [PLUS]],
      [[1, 2, 3, 4], [6, 6, 6, 6], []],
      [[1, 2, 3, 4], [2, 5, 5, 2], [MINUS]]
    ].each do |item|
      it "when result is #{item[2]}, secret code is #{item[0]} and guess is #{item[1]}" do
        game.instance_variable_set(:@secret_code, item[0].join)
        guess = item[1].join
        expect(Codebreaker::Guess.decorate(game.compare(guess))).to eq item[2].join
      end
    end
  end
end
