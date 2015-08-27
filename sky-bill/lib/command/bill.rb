require_relative '../helpers/command_helper'
require_relative 'call_charge'
require_relative 'package'
require_relative 'sky_store'
require_relative 'statement'

# Represents a sky bill.
class Bill < SkyBill::CommandHelper
  attr_reader :bill

  def initialize customer_bill = nil
    @bill = customer_bill ? JSON.parse(customer_bill) : {}
  end

  def call_charges; CallCharge.new bill[:callCharges.to_s] unless bill[:callCharges.to_s].nil?; end
  def package; Package.new bill[:package.to_s] unless bill[:package.to_s].nil?; end
  def sky_store; SkyStore.new bill[:skyStore.to_s] unless bill[:skyStore.to_s].nil?; end
  def statement; Statement.new bill[:statement.to_s] unless bill[:statement.to_s].nil?; end

  def total
    bill_total = parse_amount bill[:total.to_s]
    Money.new(bill_total, 'GBP').format
  end
end