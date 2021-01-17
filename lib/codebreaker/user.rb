# frozen_string_literal: true

module Codebreaker
  class User
    MIN_NAME_LENGTH = 3
    MAX_NAME_LENGTH = 20

    attr_reader :name, :hints_used, :attempts_used, :created_at, :difficulty

    def initialize(name)
      @name = name
      @hints_used = 0
      @attempts_used = 0
      @created_at = DateTime.now
    end

    def add_difficulty(difficulty)
      @difficulty = difficulty
    end

    def hints_total
      @difficulty.hints
    end

    def attempts_total
      @difficulty.attempts
    end

    def attempt!
      @attempts_used += 1
    end

    def hint!
      @hints_used += 1
    end

    def hints_available?
      @hints_used < @difficulty.hints
    end

    def attempts_available?
      @attempts_used < @difficulty.attempts
    end

    def reset!
      @hints_used = 0
      @attempts_used = 0
    end

    def valid?
      name.to_s.length.between?(MIN_NAME_LENGTH,
                                MAX_NAME_LENGTH) && /\A[a-zA-Z_]+\z/.match?(name.to_s)
    end
  end
end
