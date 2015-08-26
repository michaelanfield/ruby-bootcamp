# Provides reusable functionality for the sky bill application.
module SkyBill

  # Provides helper functionality for command objects e.g. parse_date
  class CommandHelper
    def parse_date date_string, format = '%d/%m/%Y'
      Date.parse(date_string).strftime(format) unless date_string.nil?
    end

    def parse_amount amount
      amount * 100 unless amount.nil?
    end
  end
end