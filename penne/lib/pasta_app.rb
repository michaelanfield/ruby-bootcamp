require_relative 'penne'

# Represents the application by defining the pages and content.
class PastaApp < Penne
  page '/home' do
    'Hello world'
  end

  page '/info' do
    'This is some info for another page'
  end
end
