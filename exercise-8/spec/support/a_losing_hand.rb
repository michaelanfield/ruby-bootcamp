shared_examples 'a losing hand' do |hands|

	hands.each do |hand| 
		it "says the losing message - #{hand.first} loses to #{hand.last}" do
			allow(input_stream).to receive(:gets).and_return(hand.first)
			allow(subject).to receive(:generate_computer_option).and_return(hand.last)
			
			subject.play
			expect(output_stream.string).to include("#{hand.first} loses to #{hand.last}")
		end
	end
end