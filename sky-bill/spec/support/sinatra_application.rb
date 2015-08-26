shared_context :sinatra_application do
  include Rack::Test::Methods

  def app
    Class.new(described_class) do |app|
      app.set :show_exceptions, false
      app.set :raise_errors, true
    end
  end
end