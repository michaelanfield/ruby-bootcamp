require_relative 'module/dsl_builder'
require_relative 'override_fixnum'

require 'json'

class Statement

	include Exercise14::DSLBuilder

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
			h[:total] = resolve_statement_total
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

	def resolve_statement_total
		total = 0

		if body.has_key? :callCharges
			total = body[:callCharges][:calls].collect { |call| call[:cost] }.reduce(0, :+).round(2)
		end

		total
	end
end