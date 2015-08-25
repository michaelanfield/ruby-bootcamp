require 'slim'

shared_context :slim_template_page do
  let(:page) do
    Slim::Template.new("views/#{self.class.top_level_description}").render self
  end
end
