class Game

	WINNING_COMBINATIONS = {
		rock: :scissors,
		scissors: :paper,
		paper: :rock
	}

	def evaluate(option_1, option_2)
		if draw?(option_1, option_2)
			"it's a draw"
		else
			"#{option_1} beats #{WINNING_COMBINATIONS[option_1.to_sym]}"
		end
	end

	private

	def draw?(option_1, option_2)
		option_1 == option_2
	end
end