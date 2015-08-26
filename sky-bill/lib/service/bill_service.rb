require_relative '../command/bill'

# Provides a means of fetching a customers bill. In this implementation it is reading
# the bill from a file located in the resources directory (and thus is not very reusable).
class BillService
  def fetch_bill
    Bill.new File.read "#{__dir__}/../resources/bill.json"
  end
end