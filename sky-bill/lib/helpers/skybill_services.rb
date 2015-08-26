require_relative '../service/bill_service'

# Provides reusable functionality for the sky bill application.
module SkyBill

  # Defines the services for use within the application.
  module Services
    def bill_service; BillService.new; end
  end
end