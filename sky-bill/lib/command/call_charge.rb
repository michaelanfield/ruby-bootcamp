require_relative 'call'

# Represents a call charge containing calls and the total cost.
class CallCharge < SkyBill::CommandHelper

  attr_reader :total, :calls

  def initialize call_charges = {}
    @total = parse_amount call_charges[:total.to_s]
    @calls = []
      
    call_charges[:calls.to_s].each do |call| 
      calls << Call.new(call)
    end
  end

  def total
    Money.new(@total, 'GBP').format
  end
end