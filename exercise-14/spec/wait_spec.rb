require 'pry'

module Wait
	
	def until 
		outcome = yield

		while !outcome
			outcome = yield
		end

		outcome
	end
end

describe Wait do
	# Define a module called Wait 
	# With an until method 
	# method should take a block which will execute until it returns true

	subject { Object.new.extend(Wait) }

	describe '#until' do
		it 'will execute block until it returns true' do
			until_outcome = subject.until { rand(9) % 2 == 0 }

			expect(until_outcome).to be(true)
		end
	end
end