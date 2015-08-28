shared_examples :a_subscription_record do |row_number, title, cost|
  
  it "with record #{row_number} having a title of #{title} and a cost of #{cost}" do
    expect(subscriptions.native.search("tr[#{row_number}]").search('td[1]').text).to eq title
    expect(subscriptions.native.search("tr[#{row_number}]").search('td[2]').text).to eq cost
  end
end