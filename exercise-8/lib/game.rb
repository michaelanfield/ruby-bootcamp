class Game

	WINNING_COMBINATIONS = {
		rock: :scissors,
		scissors: :paper,
		paper: :rock
	}

	def capture_option
		puts 'Pick your poison; rock, paper or scissors'
		gets
	end

	def play
		puts evaluate(capture_option, random_option)
	end

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

	def random_option
		WINNING_COMBINATIONS.keys.sample
	end
end