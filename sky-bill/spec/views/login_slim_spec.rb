require 'spec_helper'

describe 'login.slim' do
  include_context :slim_template_page

  shared_examples :a_page_with_inputs do |*field_names|
    field_names.each do |field_name|
      it "for #{field_name}" do
        expect(page.has_field? field_name).to be true
      end
    end
  end

  it_behaves_like :a_page_with_inputs, 'username', 'password'

  it 'will have a login button' do
    expect(page.has_button? 'Login').to be true
  end
end
