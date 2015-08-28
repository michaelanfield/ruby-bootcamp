shared_examples :a_page_with_inputs do |*field_names|
  field_names.each do |field_name|
    it "for #{field_name}" do
      expect(page.send(field_name)).to be_visible
    end
  end
end