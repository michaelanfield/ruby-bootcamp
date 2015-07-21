require 'pry'
require 'timecop'

require_relative '../lib/wait'

describe Wait do

	describe '#until' do
		it 'will execute block until it returns true' do
			expect(Wait.until { rand(999) % 2 == 0 }).to be(true)
		end

		it 'will not execute if no block is given' do
			begin
				Wait.until
				fail 'Expected a Wait::NoBlockGivenError'
			rescue Wait::NoBlockGivenError => error
				expect(error.to_s).to match(/You muppet! Please supply a block to execute./)
			end
		end

		it 'will wait 0.01 second between block executions' do
			expect(Wait.until(:retry_time => 0.01) { rand(999) % 2 == 0 }).to be(true)
		end

		it 'will expire after 5 seconds by default' do
			start_time = Time.now

			Timecop.scale(60)

			begin
				Wait.until { false }
				fail 'Expected a Wait::TimeOutError'
			rescue Wait::TimeOutError => error
				expect(error.to_s).to match(/Timed out waiting, 5 seconds elapsed/)
			end

			expect(Time.now - start_time).to be >= 5
		end

		it 'will expire after 0.01 seconds' do
			start_time = Time.now

			begin
				Wait.until(:expire_after => 0.01) { false }
				fail 'Expected a Wait::TimeOutError'
			rescue Wait::TimeOutError => error
				expect(error.to_s).to match(/Timed out waiting, 0.01 seconds elapsed/)
			end

			expect(Time.now - start_time).to be >= 0.01
		end
	end
end