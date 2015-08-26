class Subscription < SkyBill::CommandHelper
  attr_reader :type, :name, :cost

  def initialize subscription
    @type = subscription[:type.to_s]
    @name = subscription[:name.to_s]
    @cost = parse_amount subscription[:cost.to_s]
  end

  def cost
    Money.new(@cost, 'GBP').format
  end
end