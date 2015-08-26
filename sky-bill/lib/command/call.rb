# Represents a call made.
class Call < SkyBill::CommandHelper
  attr_reader :called, :duration, :cost

  def initialize call
    @called = call[:called.to_s]
    @duration = call[:duration.to_s]
    @cost = parse_amount call[:cost.to_s]
  end

  def cost
    Money.new(@cost, 'GBP').format
  end
end