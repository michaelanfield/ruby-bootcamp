require 'spec_helper'

describe 'bill.slim' do
  include_context :slim_template_page

  let(:page) do
    bill = Bill.new '''
      {
        "statement": {"generated": "2015-01-11","due": "2015-01-25", "period": {"from": "2015-01-26","to": "2015-02-25"}}, 
        "total": 136.03,
        "package": {
          "subscriptions": [
            { "type": "tv", "name": "Variety with Movies HD", "cost": 50.00 },
            { "type": "talk", "name": "Sky Talk Anytime", "cost": 5.00 },
            { "type": "broadband", "name": "Fibre Unlimited", "cost": 16.40 }
          ],
          "total": 71.40
        },
        "callCharges": {
          "calls": [
            { "called": "07716393769", "duration": "00:23:03", "cost": 2.13 },
            { "called": "07716393769", "duration": "00:23:03", "cost": 2.13 },
            { "called": "07716393769", "duration": "00:23:03", "cost": 2.13 },
            { "called": "07716393769", "duration": "00:23:03", "cost": 2.13 },
            { "called": "07716393769", "duration": "00:23:03", "cost": 2.13 }
          ],
          "total": 59.64
        },
        "skyStore": {
          "rentals": [
            { "title": "50 Shades of Grey", "cost": 4.99 }
          ],
          "buyAndKeep": [
            { "title": "That\'s what she said", "cost": 9.99 },
            { "title": "Broke back mountain", "cost": 9.99 }
          ],
          "total": 24.97
        }
      }
    '''
    BillPage.new(render bill: bill)
  end

  it 'will contain the title Your Bill' do
    expect(page.title).to eq 'Your Bill'
  end

  it 'will have a means to logout' do
    expect(page.logout_button).to be_visible
  end

  describe 'will have a header' do
    it 'with a title of Bill' do
      expect(page.header_title.text).to eq 'Bill'
    end

    it 'with a logo' do
      expect(page.header_logo).to be_visible
    end
  end

  describe 'will have a statement header' do
    it 'with a title of Latest bill' do
      expect(page.statement_period.text).to include 'Latest bill'
    end

    it 'with a statement from date' do
      expect(page.statement_period.from.text).to eq '26 Jan'
    end

    it 'with a statement to date' do
      expect(page.statement_period.to.text).to eq '25 Feb'
    end
  end

  describe 'will have a package section' do
    it 'with a title of Packages' do
      expect(page.packages.title).to have_text 'Packages'
    end

    it 'with a cost' do
      expect(page.packages.cost).to have_text '£71.40'
    end

    it 'will have a breakdown that is collapsed' do
      expect(page.packages.breakdown.native.attributes['class'].value).to eq 'collapse'
    end

    it 'will have 3 subscriptions' do
      expect(page.packages.breakdown.subscriptions.native.search('tr').size).to eq 3
    end
  end

  describe 'will have a call charges section' do
    it 'with a title of Calls' do
      expect(page.calls.title).to have_text 'Calls'
    end

    it 'with a cost' do
      expect(page.calls.cost).to have_text '£59.64'
    end

    it 'will have a breakdown that is collapsed' do
      expect(page.calls.breakdown.native.attributes['class'].value).to eq 'collapse'
    end

    it 'will have 5 calls in the call history' do
      expect(page.calls.breakdown.call_history.native.search('tr').size).to eq 5
    end
  end

  describe 'will have a sky store section' do
    it 'with a title of Sky store' do
      expect(page.sky_store.title).to have_text 'Sky store'
    end

    it 'with a cost' do
      expect(page.sky_store.cost).to have_text '£24.97'
    end

    it 'will have a breakdown that is collapsed' do
      expect(page.sky_store.breakdown.native.attributes['class'].value).to eq 'collapse'
    end

    # it 'will have 5 calls in the call history' do
    #   expect(page.calls.breakdown.call_history.native.search('tr').size).to eq 5
    # end
  end
end
