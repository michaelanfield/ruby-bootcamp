require 'slim'

shared_context :slim_template_page do
  let(:page) do
    template = Slim::Template.new("views/#{self.class.top_level_description}").render self
    PageMagic::Session.new(Capybara::Node::Simple.new(template)).browser
  end
end
