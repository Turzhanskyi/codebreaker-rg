# frozen_string_literal: true

module Codebreaker
  class Guess
    attr_reader :value

    def initialize(value)
      @value = value
      @valid = true
    end

    def valid?
      start_range = Game::CODE_START_RANGE
      end_range = Game::CODE_END_RANGE
      unless /^[#{start_range}-#{end_range}]{#{Game::CODE_LENGTH}}$/.match @value.to_s
        @valid = false
      end
      @valid
    end
  end
end
