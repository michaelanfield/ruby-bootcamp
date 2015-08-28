require 'spec_helper'

describe 'login.slim' do
  include_context :slim_template_page

  let(:page) do
    LoginPage.new render
  end

  it 'will have a header with a title of Lets get you in' do
    expect(page.header_title.text).to eq "Let's get you in"
  end

  it_behaves_like :a_page_with_inputs, 'username', 'password'

  it 'will have a login button' do
    expect(page.login_button).to be_visible
  end
end
