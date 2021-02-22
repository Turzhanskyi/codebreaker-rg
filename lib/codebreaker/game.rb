# frozen_string_literal: true

module Codebreaker
  class Game
    attr_reader :user, :difficulty, :secret_code, :hints_used, :attempts_used

    def initialize(user, difficulty)
      @user = user
      @difficulty = difficulty.level
      @secret_code = code_generator
      assign_hints
      @hints_used = 0
      @attempts_used = 0
    end

    def hints_total
      @difficulty[:hints]
    end

    def attempts_total
      @difficulty[:attempts]
    end

    def attempt
      @attempts_used += 1
    end

    def increment_hint
      @hints_used += 1
    end

    def hints_available?
      @hints_used < @difficulty[:hints]
    end

    def attempts_available?
      @attempts_used < @difficulty[:attempts]
    end

    def win?(user_code)
      secret_code == user_code.to_s
    end

    def compare(user_code)
      if win?(user_code) || !attempts_available?
        return Codebreaker::Constants::PLUS * Codebreaker::Constants::CODE_LENGTH
      end

      attempt
      compare_codes(user_code)
    end

    def hint
      increment_hint if hints_available?

      @hints.pop
    end

    private

    def assign_hints
      @hints = @secret_code.chars.sample(difficulty[:hints])
    end

    def code_generator
      Array.new(Codebreaker::Constants::CODE_LENGTH) do
        rand(Codebreaker::Constants::CODE_RANGE)
      end.join
    end

    def compare_codes(user_code)
      secret_codes = @secret_code.chars
      user_codes = user_code.chars
      output = strong_match(secret_codes, user_codes)
      output + not_strong_match(secret_codes, user_codes)
    end

    def strong_match(secret_codes, user_codes)
      output = ''
      secret_codes.each_with_index do |code, index|
        next unless code == user_codes[index]

        output += Codebreaker::Constants::PLUS
        secret_codes[index] = nil
        user_codes[index] = nil
      end
      output
    end

    def not_strong_match(secret_codes, user_codes)
      output = ''
      secret_codes.each do |code|
        next unless code && user_codes.include?(code)

        output += Codebreaker::Constants::MINUS
        user_codes.delete_at(user_codes.index(code))
      end
      output
    end
  end
end
