
shared_context :rack_test do
  include Rack::Test::Methods

  let(:app) { described_class.new }
end
