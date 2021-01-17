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
      error_message = I18n.t(:'errors.guess.length', length: Game::CODE_LENGTH)
      errors << error_message unless @value.to_s.chars.length == Game::CODE_LENGTH
    end

    def validate_range
      error_message = I18n.t(:'errors.guess.range', range: Game::CODE_RANGE)
      allowed_range = Game::CODE_RANGE.to_a
      is_valid_range = @value.to_s.chars.map(&:to_i).all? { |n| allowed_range.include? n }
      errors << error_message unless is_valid_range
    end
  end
end
