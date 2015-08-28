shared_examples :a_call_record do |row_number, called_number, duration, cost|
  
  it "with record #{row_number} calling #{called_number} for #{duration} at a cost of #{cost}" do
    expect(call_history.native.search("tr[#{row_number}]").search('td[1]').text).to eq called_number
    expect(call_history.native.search("tr[#{row_number}]").search('td[2]').text).to eq duration
    expect(call_history.native.search("tr[#{row_number}]").search('td[3]').text).to eq cost
  end
end