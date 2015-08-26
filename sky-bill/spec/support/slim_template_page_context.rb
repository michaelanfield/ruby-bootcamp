require 'slim'

shared_context :slim_template_page do

  let(:page_class) { LoginPage }

  let(:page) do
    template = Slim::Template.new("views/#{self.class.top_level_description}").render self
    page_class.new PageMagic::Session.new(Capybara::Node::Simple.new(template))
  end
end
