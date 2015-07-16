# Represents a game that requires one type of poison to over power another type
# of poison. These rules can be supplied when the game is created but will
# default to rock, paper, scissors.
class Game

	MESSAGES = {
		win: '%s totally obliterates %s',
		lose: '%s is done in by %s',
		draw: 'You get to live another day!'
	}

	DEFAULT_POISONS = {
		rock: :scissors, 
		paper: :rock, 
		scissors: :paper
	}

	attr_reader :input, 
							:output, 
							:user_option, 
							:computer_option, 
							:poison_engine

	def initialize(input_stream = $stdin, output_stream = $stdout, poisons = DEFAULT_POISONS)
		@input = input_stream
		@output = output_stream
		@poison_engine = PoisonEngine.new(poisons)
	end

	def play
		display_instructions
		@user_option = capture_user_option
		@computer_option = generate_computer_option

		output.puts decide(user_option, computer_option)
	end

	private 
	def display_instructions
		output.puts 'Pick your poison; rock, paper or scissors'
	end

	def capture_user_option
		input.gets
	end

	def generate_computer_option
		poison_engine.generate_sample_poison
	end

	def decide(user_option, computer_option)
		case poison_engine.compare(user_option, computer_option)
		when 1
			MESSAGES[:win] % [user_option, computer_option]
		when -1
			MESSAGES[:lose] % [user_option, computer_option]
		else
			MESSAGES[:draw]
		end
	end
end

class PoisonEngine
	attr_reader :poisons

	def initialize(supplied_poisons)
		@poisons = {}

		supplied_poisons.each do |flavour, over_powers| 
			poisons[flavour] = Poison.new(flavour, over_powers) 
		end
	end

	def generate_sample_poison
		poisons.keys.sample.to_s
	end

	def compare(user_option, computer_option)
		get_poison(user_option) <=> get_poison(computer_option)
	end

	private	
	def get_poison(flavour)
		poisons[flavour.to_sym] unless !flavour
	end
end

class Poison
	attr_reader :flavour,
							:over_powers

	def initialize(flavour, over_powers) 
		@flavour = flavour
		@over_powers = over_powers
	end

	def <=>(poison)
		if poison.over_powers == flavour
			return -1
		elsif over_powers == poison.flavour
			return 1
		else 
			return 0
		end
	end
end	