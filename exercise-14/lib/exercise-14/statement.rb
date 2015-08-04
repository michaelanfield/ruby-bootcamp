require_relative 'module/dynamic_attributes'
require_relative 'override_fixnum'

require 'json'

# Defines a statement or bill
class Statement
  extend Exercise14::DynamicAttributes

  define_attribute :date,
                   :due,
                   :from,
                   :to

  def initialize(&block)
    instance_eval(&block) if block_given?
  end

  def call_charges(&block)
    @call_charges = CallCharges.new(&block) if block_given?

    @call_charges
  end

  def total
    call_charges ? call_charges.total_cost : 0
  end

  # rubocop:disable Metrics/MethodLength
  def to_json
    JSON.generate(
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
    )
  end

  # Defines call charges used within a statement
  class CallCharges
    attr_reader :calls

    def initialize(&block)
      @calls = []
      instance_eval(&block) if block_given?
    end

    def call(phone_number, &block)
      calls << Call.new(phone_number, &block) if block_given?

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
