# Represents a customers package.
class Package < SkyBill::CommandHelper

  attr_reader :total, :subscriptions

  def initialize package = {}
    @total = parse_amount package[:total.to_s]
    @subscriptions = []
      
    package[:subscriptions.to_s].each do |subscription| 
      subscriptions << Subscription.new(subscription)
    end
  end

  def total
    Money.new(@total, 'GBP').format
  end
end