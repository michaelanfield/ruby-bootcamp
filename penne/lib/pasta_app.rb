require_relative 'penne'

# Represents the application by defining the pages and content.
class PastaApp < Penne
  page '/home' do
    view :home
  end

  page '/info' do
    view :info
  end
end
