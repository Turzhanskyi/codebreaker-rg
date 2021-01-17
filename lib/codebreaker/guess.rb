# frozen_string_literal: true

module Codebreaker
  class Guess
    attr_reader :value, :errors

    def initialize(value)
      @value = value
      @errors = []
    end

    def valid?
      validate
      errors.empty?
    end

    private

    def validate
      validate_length
      validate_range if errors.empty?
    end

    def validate_length
      error_message = "guess should have #{Game::CODE_LENGTH} codes length"
      errors << error_message unless @value.to_s.chars.length == Game::CODE_LENGTH
    end

    def validate_range
      error_message = "each guess code is allowed in #{Game::CODE_RANGE} range inclusively"
      allowed_range = Game::CODE_RANGE.to_a
      is_valid_range = @value.to_s.chars.map(&:to_i).all? { |n| allowed_range.include? n }
      errors << error_message unless is_valid_range
    end
  end
end
