module Ranked
  module Ranking

    def self.ladder
      ladder = []
      Result.order(:at).each do |r|
        ladder.push(r.winner_id) unless ladder.include?(r.winner_id)
        ladder.push(r.loser_id) unless ladder.include?(r.loser_id)

        winner_index = ladder.index(r.winner_id)
        loser_index = ladder.index(r.loser_id)

        if winner_index > loser_index
          ladder.delete_at(winner_index)
          ladder = ladder.insert(loser_index, r.winner_id)
        end
      end

      ladder.map { |i| Player[i] }
    end

  end
end
