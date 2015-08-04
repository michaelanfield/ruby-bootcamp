require_relative 'module/dsl_builder'

class Call
  include Exercise14::DSLBuilder

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