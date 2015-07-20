require 'pry'

module Wait
	
	def self.until(options = {}, &block)
		raise NoBlockGivenError, 'You muppet! Please supply a block to execute.' unless block_given? 

		retry_time = options.delete(:retry_time) || 0
		
		outcome = yield

		while !outcome
			sleep(retry_time)

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
			expect(Wait.until { rand(999) % 2 == 0 }).to be(true)
		end

		it 'will not execute if no block is given' do
			expect{ Wait.until }.to raise_error(Wait::NoBlockGivenError)
		end

		it 'will wait 1 second between block executions' do
			expect(Wait.until(:retry_time => 1) { rand(999) % 2 == 0 }).to be(true)
		end
	end
end