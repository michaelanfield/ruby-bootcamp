require 'spec_helper'

describe 'bill.slim' do
  include_context :slim_template_page

  it 'will contain the title Your Bill' do
    expect(page.title).to eq 'Your Bill'
  end
end
