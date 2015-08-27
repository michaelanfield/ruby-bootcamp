require_relative 'store_item'

# Represents a customers sky store interactions.
class SkyStore < SkyBill::CommandHelper

  attr_reader :total, :rentals, :buy_and_keep

  def initialize sky_store = {}
    @total = parse_amount sky_store[:total.to_s]
    @rentals = []
    @buy_and_keep = []

    sky_store[:rentals.to_s].each do |rental|
      rentals << StoreItem.new(rental)
    end

    sky_store[:buyAndKeep.to_s].each do |item|
      buy_and_keep << StoreItem.new(item)
    end
  end

  def total
    Money.new(@total, 'GBP').format
  end
end