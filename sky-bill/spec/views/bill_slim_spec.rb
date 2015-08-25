require 'spec_helper'

describe 'bill.slim', type: :view do
  include_context :slim_template_page

  it 'will have contain the text Your Bill' do
    expect(page).to include 'Your Bill'
  end
end
