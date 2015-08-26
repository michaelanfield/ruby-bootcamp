# Represents a store item with a title and a cost.
class StoreItem < SkyBill::CommandHelper
  attr_reader :title, :cost

  def initialize store_item = {}
    @cost = parse_amount store_item[:cost.to_s]
    @title = store_item[:title.to_s]
  end

  def cost
    Money.new(@cost, 'GBP').format
  end
end