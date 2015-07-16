shared_examples 'a winning hand' do |hands|

	hands.each do |hand| 
		it "says the winning message - #{hand.first} beats #{hand.last}" do
			allow(input_stream).to receive(:gets).and_return(hand.first)
			allow(subject).to receive(:generate_computer_option).and_return(hand.last)
			
			subject.play
			expect(output_stream.string).to include("#{hand.first} beats #{hand.last}")
		end
	end
end