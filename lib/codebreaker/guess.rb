# frozen_string_literal: true

module Codebreaker
  class Guess
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def valid?
      start_range = Game::CODE_RANGE.min
      end_range = Game::CODE_RANGE.max
      @value.to_s =~ /^[#{start_range}-#{end_range}]{#{Game::CODE_LENGTH}}$/ ? true : false
    end
  end
end
