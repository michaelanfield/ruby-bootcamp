# Represents a statement for a bill.
class Statement < SkyBill::CommandHelper

  attr_reader :generated, :due, :from, :to

  def initialize statement = {}
    @generated = parse_date statement[:generated.to_s]
    @due = parse_date statement[:due.to_s]
    @from = parse_date statement[:period.to_s][:from.to_s]
    @to = parse_date statement[:period.to_s][:to.to_s]
  end
end