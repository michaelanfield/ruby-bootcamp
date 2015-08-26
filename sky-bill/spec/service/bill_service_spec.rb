require 'spec_helper'

describe BillService do
  let(:service) { BillService.new }

  describe '#fetch_bill' do
    it 'will respond to fetch_bill' do
      expect(service).to respond_to :fetch_bill
    end

    it 'will return a bill' do
      expect(service.fetch_bill).to be_a Bill
    end
  end
end