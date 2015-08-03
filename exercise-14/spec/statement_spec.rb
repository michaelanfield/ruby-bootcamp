require 'pry'
require 'json'

require_relative '../lib/exercise-14/statement'
require_relative '../lib/exercise-14/call'

describe Statement do

	context '#to_json' do

		it 'will have a statement with an automatically generated date' do
			expected_generated_date = Date.today

			statement = Statement.build

			generated_date = JSON.parse(statement.to_json)['statement']['generated']

			expect(generated_date).to eq(expected_generated_date.to_s)
		end

		it 'will have a statement with a given generated date' do
			expected_generated_date = Date.parse('2015-01-01')

			statement = Statement.build do
				date Date.parse('2015-01-01')
			end

			generated_date = JSON.parse(statement.to_json)['statement']['generated']

			expect(generated_date).to eq(expected_generated_date.to_s)
		end

		it 'will have a statement with a given generated and due date' do
			expected_generated_date = Date.today
			expected_due_date = expected_generated_date + 30

			statement = Statement.build do
				date Date.today
				due date + 30.days
			end

			generated_date = JSON.parse(statement.to_json)['statement']['generated']
			due_date = JSON.parse(statement.to_json)['statement']['due']

			expect(generated_date).to eq(expected_generated_date.to_s)
			expect(due_date).to eq(expected_due_date.to_s)
		end

		it 'will have a period that contains from and to dates' do
			expected_from_date = Date.parse('2015-01-01')
			expected_to_date = Date.parse('2015-01-31')

			statement = Statement.build do
				from Date.parse('2015-01-01')
				to Date.parse('2015-01-31')
			end

			from_date = JSON.parse(statement.to_json)['statement']['period']['from']
			to_date = JSON.parse(statement.to_json)['statement']['period']['to']

			expect(from_date).to eq(expected_from_date.to_s)
			expect(to_date).to eq(expected_to_date.to_s)
		end

		it 'will have call charges that contain calls' do
			expected_call_1 = { "called" => "07716393769", "date" => "2015-01-26", "duration" => "00:23:03", "cost" => 1.13 }
			expected_call_2 = { "called" => "07719999999", "date" => "2015-01-28", "duration" => "00:12:23", "cost" => 0.20 }

			statement = Statement.build do
				call_charges do
					call '07716393769' do
						date Date.parse('2015-01-26')
			      duration "00:23:03"
			      cost 1.13
			    end
			    call '07719999999' do
						date Date.parse('2015-01-28')
			      duration "00:12:23"
			      cost 0.20
			    end
				end
			end

			call_1 = JSON.parse(statement.to_json)['statement']['callCharges']['calls'].first
			call_2 = JSON.parse(statement.to_json)['statement']['callCharges']['calls'].last

			expect(call_1).to eq(expected_call_1)
			expect(call_2).to eq(expected_call_2)
		end

		it 'will have a total based on the call charges' do
			statement = Statement.build do
				call_charges do
					call '07716393769' do
						date Date.parse('2015-01-26')
			      duration "00:23:03"
			      cost 1.13
			    end
			    call '07719999999' do
						date Date.parse('2015-01-28')
			      duration "00:12:23"
			      cost 0.20
			    end
				end
			end

			total_cost = JSON.parse(statement.to_json)['statement']['total']

			expect(total_cost).to eq 1.33
		end
	end
end
