shared_context :capybara_test do
  Capybara.app = described_class

  Sinatra::Base.set :root, "#{__dir__}/../.."
end
