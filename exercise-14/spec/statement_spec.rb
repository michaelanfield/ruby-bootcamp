require 'pry'
require 'json'

module DSLBuilder

	attr_reader :method_name_overrides, 
							:method_data_types,
							:body

	def method_missing(method, *args, &block)
		debug_method_call(method, *args)

		method_name = clean_method_name(method)

		if block_given?
			if !args.empty?
				method_value = Call.build(args, &block).body
			else
				method_value = Statement.build(@debug, *args, &block).body
			end
			#instance_eval(&block)

			p "Method #{method_name}, with block has a value of: #{method_value}"

			register_method_value(method_name, method_value)
		else
			register_method_value(method_name, args.first)
		end
	end

	private 
	def clean_method_name(method_name)
		debug_method_call('clean_method_name', method_name)

		method_name.to_s.camel_case_lower.to_sym
	end

	def register_method_value(method_name, method_value)
		debug_method_call('register_method_value', method_name, method_value)

		method_override = method_name_overrides[method_name]

		if method_override && ( method_override.is_a? Array )	

			method_override.each_with_index do |override, index|
				body[override] = body[override] || {}

				body[override][method_name] = method_value
			end
		else
			method_data_type = method_data_types[method_name]

p "Method data type for '#{method_name}' is: #{method_data_type}"

			if method_data_type && method_data_type.is_a?(Array)
				p 'We have an array'
				body[method_override || method_name] = body[method_override || method_name] || method_data_type

				body[method_override || method_name] << method_value 
			else
				body[method_override || method_name] = method_value
			end
		end
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

class Statement

	include DSLBuilder

	def self.build(debug = false, *args, &block)
		statement = Statement.new(debug)
		statement.instance_eval(&block) if block_given?
		statement
	end

	def initialize(debug)
		@body = {}
		@debug = debug
		@method_name_overrides = {
			:date => :generated,
			:from => [:period],
			:to => [:period],
			:call => :calls
		}
		@method_data_types = {
			:call => []
		}
	end

  def to_json
  	statement = {
  		:statement => (body || {})
		}

		statement[:statement].tap do |h|
			h[:generated] = @date || Date.today
		end

		p statement.to_json if @debug

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
end

class Call
	include DSLBuilder

	def self.build(*args, &block)
		call = Call.new(args.flatten.first)
		call.instance_eval(&block) if block_given?
		call
	end

	def initialize(phone_number)
		@body = {}
		@method_name_overrides = {}
		@method_data_types = {}

		body[:called] = phone_number
	end
end	

class Fixnum
	def days
		self
	end
end		

class String
  def camel_case_lower
    self.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
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

			statement = Statement.build(true) do
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
	end
end
