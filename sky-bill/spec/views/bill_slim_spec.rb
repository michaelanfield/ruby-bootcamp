describe 'bill.slim', type: :view do
  include_context :slim_template_page

  before do
    #Sinatra::Base.set :root, "#{__dir__}/../.."
  end

  it 'will have contain the text Your Bill' do
    #render

    #p rendered
    expect(page).to include 'Your Bill'
  end
end
