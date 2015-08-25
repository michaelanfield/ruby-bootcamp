require 'spec_helper'

describe 'bill.slim' do
  include_context :slim_template_page

  it 'will contain the text Your Bill' do
    expect(page.assert_text :visible, 'Your Bill', :minimum => 1).to be true
  end
end
