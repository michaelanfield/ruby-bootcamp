require_relative 'module/dynamic_attributes'

# Defines a phone call
class Call
  extend Exercise14::DynamicAttributes

  define_attribute :called,
                   :date,
                   :duration,
                   :cost

  def initialize(phone_number, &block)
    called phone_number
    instance_eval(&block) if block_given?
  end

  def to_json
    instance_variables.inject({}) do |buffer, var|
      buffer.tap do |b|
        b[var.to_s.delete '@'] = instance_variable_get(var)
      end
    end
  end
end
