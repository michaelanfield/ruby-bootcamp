require 'spec_helper'

describe PastaApp do
  let(:app) { subject }

  it 'will have registered a home and info page' do
    pages = subject.class.pages

    expect(pages.size).to eq 2
    expect(pages).to include '/home'
    expect(pages).to include '/info'
  end
end
