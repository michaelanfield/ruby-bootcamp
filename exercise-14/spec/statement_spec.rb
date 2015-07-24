require 'pry'
require 'json'

class Statement

	METHOD_NAME_OVERRIDES = {
		:date => :generated,
		:from => [:period, :from]
	}

	attr_reader :body

	def self.build(debug = false, &block)
		statement = Statement.new(debug)
		statement.instance_eval(&block) unless !block_given?
		statement
	end

	def initialize(debug = false)
		@body = {}
		@debug = debug
	end

	def method_missing(method, *args, &block)
		debug_method_call(method, *args)

		body[METHOD_NAME_OVERRIDES[method] || method] = block_given? ? instance_eval(&block) : args.first
  end

  def to_json
  	statement = {
  		:statement => (body || {})
		}

		statement[:statement].tap do |h|
			h[:generated] = @date || Date.today
		end

  	statement.to_json
  end

	private 
	def date(date_in = nil)
		debug_method_call(:date, date_in)

		if date_in
			@date = date_in
		end

		@date
	end

	def resolve_method_location()
	end

	def debug_method_call(method, *args)
		if @debug
			p "Calling method #{method}"
			args.each_with_index do |arg, index|
				p "#{index} - #{arg}:#{arg.class}"
			end
		end
	end
end

class Fixnum
	def days
		self
	end
end		

describe Statement do

	context '#to_json' do

		it 'will have a statement' do
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

		it 'will have a statement with generated and due date' do
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

		it 'will have a period with a from and to' do
			expected_from_date = Date.parse('2015-01-01')
			expected_to_date = Date.parse('2015-01-31')

			statement = Statement.build(true) do
				from Date.parse('2015-01-01')
				to Date.parse('2015-01-31')
			end

			from_date = JSON.parse(statement.to_json)['statement']['period']['from']
			to_date = JSON.parse(statement.to_json)['statement']['period']['to']

			expect(from_date).to eq(expected_from_date.to_s)
			expect(to_date).to eq(expected_to_date.to_s)
		end
	end
end
