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
            { "called": "07716393760", "duration": "00:25:03", "cost": 3.13 },
            { "called": "07716393761", "duration": "00:21:03", "cost": 2.43 },
            { "called": "07716393762", "duration": "00:29:03", "cost": 2.11 },
            { "called": "07716393763", "duration": "00:24:03", "cost": 2.93 }
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

    context '#subscriptions' do
      let(:subscriptions) { page.packages.breakdown.subscriptions }

      it_behaves_like :a_subscription_record, 1, 'Variety with Movies HD', '£50.00'
      it_behaves_like :a_subscription_record, 2, 'Sky Talk Anytime', '£5.00'
      it_behaves_like :a_subscription_record, 3, 'Fibre Unlimited', '£16.40'
    end
  end

  describe 'will have a call charges section' do
    it 'with a title of Calls' do
      expect(page.calls.title).to have_text 'Calls'
    end

    it 'with a cost' do
      expect(page.calls.cost).to have_text '£59.64'
    end

    context '#call_history' do
      let(:call_history) { page.calls.breakdown.call_history }

      it_behaves_like :a_call_record, 1, '07716393769', '00:23:03', '£2.13'
      it_behaves_like :a_call_record, 2, '07716393760', '00:25:03', '£3.13'
      it_behaves_like :a_call_record, 3, '07716393761', '00:21:03', '£2.43'
      it_behaves_like :a_call_record, 4, '07716393762', '00:29:03', '£2.11'
      it_behaves_like :a_call_record, 5, '07716393763', '00:24:03', '£2.93'
    end
  end

  describe 'will have a sky store section' do
    it 'with a title of Sky store' do
      expect(page.sky_store.title).to have_text 'Sky store'
    end

    it 'with a cost' do
      expect(page.sky_store.cost).to have_text '£24.97'
    end

    context '#rentals' do
      let(:store_items) { page.sky_store.breakdown.rentals }

      it_behaves_like :a_store_purchase_item, 1, '50 Shades of Grey', '£4.99'
    end

    context '#buy_and_keep' do
      let(:store_items) { page.sky_store.breakdown.buy_and_keep }

      it_behaves_like :a_store_purchase_item, 1, 'That\'s what she said', '£9.99'
      it_behaves_like :a_store_purchase_item, 2, 'Broke back mountain', '£9.99'
    end
  end
end
