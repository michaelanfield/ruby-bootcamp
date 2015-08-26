require_relative '../helpers/command_helper'

# Represents a sky bill.
class Bill < SkyBill::CommandHelper
  attr_reader :bill

  def initialize customer_bill = nil
    @bill = customer_bill ? JSON.parse(customer_bill) : {}
  end

  def call_charges; CallCharge.new bill[:callCharges.to_s]; end
  def package; Package.new bill[:package.to_s]; end
  def sky_store; SkyStore.new bill[:skyStore.to_s]; end
  def statement; Statement.new bill[:statement.to_s]; end

  def total
    bill_total = parse_amount bill[:total.to_s]
    Money.new(bill_total, 'GBP').format
  end
end