require 'pry'

module Wait
	
	def self.until 
		raise NoBlockGivenError, 'You muppet! Please supply a block to execute.' unless block_given? 

		outcome = yield

		while !outcome
			outcome = yield
		end

		true
	end

	class NoBlockGivenError < StandardError; end
end

describe Wait do
	# Define a module called Wait 
	# With an until method 
	# method should take a block which will execute until it returns true

	describe '#until' do
		it 'will execute block until it returns true' do
			until_outcome = Wait.until { rand(999) % 2 == 0 }

			expect(until_outcome).to be(true)
		end

		it 'will not execute if no block is given' do
			expect{ Wait.until }.to raise_error(Wait::NoBlockGivenError)
		end
	end
end