require 'slim'

shared_context :slim_template_page do

  def render locals = {}
    template = Slim::Template.new("views/#{self.class.top_level_description}").render self, locals
    PageMagic::Session.new(Capybara::Node::Simple.new(template))
  end
end
