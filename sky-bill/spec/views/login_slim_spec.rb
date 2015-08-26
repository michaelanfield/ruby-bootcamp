require 'spec_helper'

describe 'login.slim' do
  include_context :slim_template_page

  shared_examples :a_page_with_inputs do |*field_names|
    field_names.each do |field_name|
      it "for #{field_name}" do
        expect(page.send(field_name)).to be_visible
      end
    end
  end

  it_behaves_like :a_page_with_inputs, 'username', 'password'

  it 'will have a login button' do
    expect(page.login_button).to be_visible
  end
end
