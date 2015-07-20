require 'pry'

module Wait
	
	def self.until(options = {}, &block)
		raise NoBlockGivenError, 'You muppet! Please supply a block to execute.' unless block_given? 

		retry_time = options.delete(:retry_time) || 0
		expire_after = options.delete(:expire_after) || 5

		start_time = Time.now

		outcome = yield

		while !outcome
			current_time = Time.now

			raise TimeOutError, "Timed out waiting, #{expire_after} seconds elapsed" if current_time - start_time >= expire_after

			sleep(retry_time)

			outcome = yield
		end

		true
	end

	class NoBlockGivenError < StandardError; end

	class TimeOutError < StandardError; end
end

describe Wait do

	describe '#until' do
		it 'will execute block until it returns true' do
			expect(Wait.until { rand(999) % 2 == 0 }).to be(true)
		end

		it 'will not execute if no block is given' do
			expect{ Wait.until }.to raise_error(Wait::NoBlockGivenError)
		end

		it 'will wait 0.01 second between block executions' do
			expect(Wait.until(:retry_time => 0.01) { rand(999) % 2 == 0 }).to be(true)
		end

		it 'will expire after 5 seconds by default' do
			start_time = Time.now

			begin
				Wait.until { false }
				fail 'Expected a Wait::TimeOutError'
			rescue Wait::TimeOutError => error
				expect(error.to_s).to include('Timed out waiting, 5 seconds elapsed')
			end

			expect(Time.now - start_time).to be >= 5
		end

		it 'will expire after 0.01 seconds' do
			start_time = Time.now

			begin
				Wait.until(:expire_after => 0.01) { false }
				fail 'Expected a Wait::TimeOutError'
			rescue Wait::TimeOutError => error
				expect(error.to_s).to include('Timed out waiting, 0.01 seconds elapsed')
			end

			expect(Time.now - start_time).to be >= 0.01
		end
	end
end