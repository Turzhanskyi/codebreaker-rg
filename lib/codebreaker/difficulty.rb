# frozen_string_literal: true

module Codebreaker
  class Difficulty
    LEVELS = { easy: { name: :easy, attempts: 15, hints: 2 },
               medium: { name: :medium, attempts: 10, hints: 1 },
               hell: { name: :hell, attempts: 5, hints: 1 } }.freeze

    attr_reader :name, :attempts, :hints

    def initialize(name)
      @difficulty = LEVELS.fetch(name) { nil }
      call if valid?
    end

    def valid?
      !@difficulty.nil?
    end

    private

    def call
      @name     = @difficulty[:name]
      @attempts = @difficulty[:attempts]
      @hints    = @difficulty[:hints]
    end
  end
end
