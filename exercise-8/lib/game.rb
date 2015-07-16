class Game
	attr_reader :input, 
							:output, 
							:user_option, 
							:computer_option, 
							:poison_engine

	def initialize(input_stream = $stdin, output_stream = $stdout)
		@input = input_stream
		@output = output_stream
		@poison_engine = PoisonEngine.new()
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
		#poison_engine.get_poison(input.gets)
		input.gets
	end

	def generate_computer_option
		poison_engine.generate_sample_poison
	end

	def decide(user_option, computer_option)
		outcome = poison_engine.get_poison(user_option) <=> poison_engine.get_poison(computer_option)
		
		if outcome == 1
			"#{user_option} beats #{computer_option}" 
		elsif outcome == -1
			"#{user_option} loses to #{computer_option}"
		else
			"Oooo, it's a draw"
		end
	end
end

class PoisonEngine
	attr_reader :poisons

	def initialize(poisons = {rock: :scissors, paper: :rock, scissors: :paper})
		@poisons = poisons.each { |flavour, over_powers| poisons[flavour] = Poison.new(flavour, over_powers) }
	end

	def generate_sample_poison
		poisons.keys.sample.to_s
	end

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