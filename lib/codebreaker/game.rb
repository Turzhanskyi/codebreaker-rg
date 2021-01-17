# frozen_string_literal: true

module Codebreaker
  class Game
    CODE_LENGTH = 4
    CODE_RANGE = (1..6).freeze
    EXACT_MATCH_SIGN = '1'
    NOT_EXACT_MATCH_SIGN = '0'
    STATUS_IN_PROGRESS = 'in progress'
    STATUS_WIN = 'win'
    STATUS_LOST = 'lost'

    attr_reader :user, :difficulty, :status, :secret_number

    def initialize(user, difficulty)
      @status = STATUS_IN_PROGRESS
      @user = user
      @difficulty = difficulty
      @user.add_difficulty(difficulty)
      @secret_number = code_generator
      assign_hints
    end

    def win?
      @status == STATUS_WIN
    end

    def lost?
      @status == STATUS_LOST
    end

    def in_progress?
      @status == STATUS_IN_PROGRESS
    end

    def compare(user_number)
      @user.attempt!
      result = compare_numbers(user_number)
      win if result == EXACT_MATCH_SIGN * CODE_LENGTH
      lost unless @user.attempts_available?
      result
    end

    def hint
      user.hint! if user.hints_available?

      @hints.pop
    end

    private

    def assign_hints
      @hints = @secret_number.to_s.chars.shuffle.sample(@user.difficulty.hints)
    end

    def code_generator
      Array.new(CODE_LENGTH) { rand(CODE_RANGE) }.join.to_i
    end

    def lost
      @status = STATUS_LOST
    end

    def win
      @status = STATUS_WIN
    end

    def compare_numbers(user_number)
      secret_digits = @secret_number.to_s.chars
      user_digits = user_number.to_s.chars
      output = strong_match(secret_digits, user_digits)
      output += not_strong_match(secret_digits, user_digits)
      output
    end

    def strong_match(secret_digits, user_digits)
      output = ''
      secret_digits.each_with_index do |digit, index|
        next unless digit == user_digits[index]

        output += EXACT_MATCH_SIGN
        secret_digits[index] = nil
        user_digits[index] = nil
      end
      output
    end

    def not_strong_match(secret_digits, user_digits)
      output = ''
      secret_digits.each do |digit|
        next unless digit && user_digits.include?(digit)

        output += NOT_EXACT_MATCH_SIGN
        user_digits.delete_at(user_digits.index(digit))
      end
      output
    end
  end
end
