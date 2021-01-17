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

  context 'with first RubyGarage Codebreaker examples matrix' do
    before do
      game.instance_variable_set(:@secret_code, '6543')
    end

    it 'guess 1100' do
      expect(game.compare('5643')).to eql '1100'
    end

    it 'guess 10' do
      expect(game.compare('6411')).to eql '10'
    end

    it 'guess 111' do
      expect(game.compare('6544')).to eql '111'
    end

    it 'guess 0000' do
      expect(game.compare('3456')).to eql '0000'
    end

    it 'guess 1' do
      expect(game.compare('6666')).to eql '1'
    end

    it 'guess 0' do
      expect(game.compare('2666')).to eql '0'
    end

    it 'guess empty' do
      expect(game.compare('2222')).to eql ''
    end
  end

  context 'with second RubyGarage Codebreaker examples matrix' do
    before do
      game.instance_variable_set(:@secret_code, '6666')
    end

    it 'guess 11' do
      expect(game.compare('1661')).to eql '11'
    end
  end

  context 'with third RubyGarage Codebreaker examples matrix' do
    before do
      game.instance_variable_set(:@secret_code, '1234')
    end

    it 'guess 1000' do
      expect(game.compare('3124')).to eql '1000'
    end

    it 'guess 110' do
      expect(game.compare('1524')).to eql '110'
    end

    it 'full guess' do
      expect(game.compare('1234')).to be '1234'
    end
  end
end
