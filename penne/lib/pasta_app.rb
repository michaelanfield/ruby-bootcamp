require_relative 'penne'

# Represents the application by defining the pages and content.
class PastaApp < Penne
  page '/home' do
    view :home
    # 'Hello world'
  end

  page '/info' do
    view :info
    # 'This is some info for another page'
  end
end
