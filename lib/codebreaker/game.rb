# frozen_string_literal: true

module Codebreaker
  class Game
    CODE_LENGTH = 4
    CODE_RANGE = (1..6).freeze
    EXACT_MATCH_SIGN = '1'
    NOT_EXACT_MATCH_SIGN = '0'

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
      return EXACT_MATCH_SIGN * CODE_LENGTH if win?(user_code) || !attempts_available?

      attempt
      compare_codes(user_code)
    end

    def hint
      increment_hint if hints_available?

      @hints.pop
    end

    private

    def assign_hints
      @hints = @secret_code.chars.shuffle.sample(difficulty[:hints])
    end

    def code_generator
      Array.new(CODE_LENGTH) { rand(CODE_RANGE) }.join.to_s
    end

    def compare_codes(user_code)
      secret_codes = @secret_code.chars
      user_codes = user_code.chars
      output = strong_match(secret_codes, user_codes)
      output += not_strong_match(secret_codes, user_codes)
      output
    end

    def strong_match(secret_codes, user_codes)
      output = ''
      secret_codes.each_with_index do |code, index|
        next unless code == user_codes[index]

        output += EXACT_MATCH_SIGN
        secret_codes[index] = nil
        user_codes[index] = nil
      end
      output
    end

    def not_strong_match(secret_codes, user_codes)
      output = ''
      secret_codes.each do |code|
        next unless code && user_codes.include?(code)

        output += NOT_EXACT_MATCH_SIGN
        user_codes.delete_at(user_codes.index(code))
      end
      output
    end
  end
end
