require 'spec_helper'

describe Bill do
  let(:command) do
    Bill.new '''
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
  end

  it 'will have a statement' do
    expect(command.statement).to be_a Statement
  end

  context '#statement' do
    let(:statement) { command.statement }

    it 'will have a generated date' do
      expect(statement.generated).to eq '11/01/2015'
    end

    it 'will have a due date' do
      expect(statement.due).to eq '25/01/2015'
    end

    it 'will have a from date' do
      expect(statement.from).to eq '26/01/2015'
    end

    it 'will have a to date' do
      expect(statement.to).to eq '25/02/2015'
    end
  end

  it 'will have a total cost' do
    expect(command.total).to eq '£136.03'
  end

  it 'will have a package' do
    expect(command.package).to be_a Package
  end

  context '#package' do
    let(:package) { command.package }

    it 'will have subscriptions' do
      expect(package.subscriptions.size).to eq 3
    end

    context '#subscriptions' do
      let(:subscription) { package.subscriptions.first }

      it 'will have a type' do
        expect(subscription.type).to eq 'tv'
      end

      it 'will have a name' do
        expect(subscription.name).to eq 'Variety with Movies HD'
      end

      it 'will have a cost' do
        expect(subscription.cost).to eq '£50.00'
      end
    end

    it 'will have a package total' do
      expect(package.total).to eq '£71.40'
    end
  end

  it 'will have call charges' do
    expect(command.call_charges).to be_a CallCharge
  end

  context '#call_charges' do
    let(:call_charges) { command.call_charges }

    it 'will have calls' do
      expect(call_charges.calls.size).to eq 5
    end

    context '#calls' do
      let(:call) { call_charges.calls.first }

      it 'will have a called number' do
        expect(call.called).to eq '07716393769'
      end

      it 'will have a duration' do
        expect(call.duration).to eq '00:23:03'
      end

      it 'will have a cost' do
        expect(call.cost).to eq '£2.13'
      end
    end

    it 'will have a call total' do
      expect(call_charges.total).to eq '£59.64'
    end
  end

  it 'will have a sky store' do
    expect(command.sky_store).to be_a SkyStore
  end

  context '#sky_store' do
    let(:sky_store) { command.sky_store }

    it 'will contain rentals' do
      expect(sky_store.rentals.size).to eq 1
    end

    it 'will contain buy and keep' do
      expect(sky_store.buy_and_keep.size).to eq 2
    end

    context '#rentals' do
      let(:store_item) { sky_store.rentals.first }

      it 'will have a title' do
        expect(store_item.title).to eq '50 Shades of Grey'
      end

      it 'will have a cost' do
        expect(store_item.cost).to eq '£4.99'
      end
    end

    it 'will have a sky store total' do
      expect(sky_store.total).to eq '£24.97'
    end
  end
end