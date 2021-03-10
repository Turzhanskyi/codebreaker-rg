# frozen_string_literal: true

module Codebreaker
  class Constants
    CODE_LENGTH = 4
    CODE_RANGE = (1..6).freeze
    NAME_LENGTH_RANGE = (3..20).freeze

    PLUS = '+'
    MINUS = '-'

    LEVELS = { easy: { name: :easy, attempts: 15, hints: 2 },
               medium: { name: :medium, attempts: 10, hints: 1 },
               hell: { name: :hell, attempts: 5, hints: 1 } }.freeze
  end
end
