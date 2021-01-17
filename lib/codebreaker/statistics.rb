# frozen_string_literal: true

module Codebreaker
  class Statistics
    class << self
      def sorted_winners(winners)
        winners.sort_by do |winner|
          [winner.difficulty.attempts, winner.difficulty.hints, winner.attempts_used,
           winner.hints_used]
        end
      end

      def decorated_top_users(top_users)
        top_users.map.with_index do |user, index|
          { rating: index + 1, name: user.name, difficulty: user.difficulty.name,
            attempts_total: user.attempts_total, attempts_used: user.attempts_used,
            hints_total: user.hints_total, hints_used: user.hints_used }
        end
      end
    end
  end
end
