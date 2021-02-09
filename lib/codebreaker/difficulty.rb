# frozen_string_literal: true

module Codebreaker
  class Difficulty
    attr_reader :level, :errors

    def initialize(name)
      @level = Codebreaker::Constants::LEVELS.fetch(name&.to_sym) { nil }
      @errors = []
    end

    def valid?
      validate
      errors.empty?
    end

    private

    def validate
      errors << I18n.t(:'errors.difficulty') if @level.nil?
    end
  end
end
