describe 'login.slim' do
  let(:page) do
    Slim::Template.new("views/#{self.class.top_level_description}").render self
  end

  shared_examples :a_page_with_inputs do |*field_names|
    field_names.each do |field_name|
      it "for #{field_name}" do
        expect(page).to include "<label>#{field_name.capitalize}", "<input name=\"#{field_name}\""
      end
    end
  end

  it_behaves_like :a_page_with_inputs, 'username', 'password'

  it 'will have a login button' do
    expect(page).to include "<button type=\"submit\"", 'Login'
  end
end
