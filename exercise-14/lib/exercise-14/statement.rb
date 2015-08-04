require_relative 'module/dynamic_attributes'
require_relative 'override_fixnum'

require 'json'

class Statement
  extend Exercise14::DynamicAttributes

  define_attribute :date, 
                   :due,
                   :from,
                   :to
  
  def initialize(&block)
    self.instance_eval(&block) if block_given?
  end

  def call_charges(&block)
    if block_given?
      @call_charges = CallCharges.new(&block)
    end

    @call_charges
  end

  def total
    total_cost = 0

    if call_charges
      total_cost = call_charges.total_cost
    end
    
    total_cost
  end

  def to_json
    JSON.generate({
        statement: {
          generated: date || Date.today,
          due: due,
          period: {
            from: from,
            to: to
          },
          callCharges: {
            calls: call_charges.to_json
          },
          total: total
        }
      })
  end

  class CallCharges
    attr_reader :calls

    def initialize(&block)
      @calls = []
      self.instance_eval(&block) if block_given?
    end

    def call(phone_number, &block)
      if block_given?
        calls << Call.new(phone_number, &block)
      end

      calls
    end

    def to_json
      @calls.map(&:to_json)
    end

    def total_cost
      @calls.map(&:cost).reduce(0, :+).round 2
    end
  end
end
