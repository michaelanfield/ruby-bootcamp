require_relative 'module/dynamic_attributes'

class Call
  extend Exercise14::DynamicAttributes

  define_attribute :called,
                   :date,
                   :duration,
                   :cost
  
  def initialize(phone_number, &block)
    called phone_number
    self.instance_eval(&block) if block_given?
  end

  def to_json
    hash = {}
    
    self.instance_variables.each do |var|
      hash[var.to_s.delete '@'] = self.instance_variable_get(var)
    end

    hash
  end
end
