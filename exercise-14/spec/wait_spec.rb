require 'pry'

module Wait
	
	def self.until 
		return false unless block_given? 

		outcome = yield

		while !outcome
			outcome = yield
		end

		true
	end
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
			expect(Wait.until).to be(false)
		end
	end
end