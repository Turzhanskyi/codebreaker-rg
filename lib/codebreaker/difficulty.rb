# frozen_string_literal: true

module Codebreaker
  class Difficulty
    attr_reader :difficulty_level, :errors

    def initialize(name)
      @difficulty_level = Codebreaker::Constants::LEVELS.fetch(name&.to_sym) { nil }
      @errors = []
    end

    def valid?
      validate
      errors.empty?
    end

    private

    def validate
      errors << I18n.t(:'errors.difficulty') if difficulty_level.nil?
    end
  end
end
