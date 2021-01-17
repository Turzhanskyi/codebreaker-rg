# frozen_string_literal: true

module Codebreaker
  class Statistics
    class << self
      def sorted_winners(winners)
        winners.sort_by do |winner|
          [winner.difficulty[:attempts], winner.difficulty[:hints],
           winner.attempts_used, winner.hints_used]
        end
      end

      def decorated_top_users(game_plays)
        game_plays.map.with_index do |game, index|
          { rating: index + 1, name: game.user.name, difficulty: game.difficulty[:name],
            attempts_total: game.attempts_total, attempts_used: game.attempts_used,
            hints_total: game.hints_total, hints_used: game.hints_used }
        end
      end
    end
  end
end
