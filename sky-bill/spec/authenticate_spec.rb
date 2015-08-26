require 'spec_helper'
require 'pry'

describe Authenticate do
  include_context :sinatra_application

  context '/bill' do

    it 'renders the bill' do
      set_cookie 'skybill_auth=true'
      expected_bill = Bill.new

      expect_any_instance_of(BillService).to receive(:fetch_bill).and_return expected_bill
      expect_any_instance_of(described_class).to receive(:slim).with(:bill, locals: {bill: expected_bill})

      get '/bill'
    end
  end
end