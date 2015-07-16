shared_examples 'a hand is played' do |hands, message|

	hands.each do |hand| 
		it "#{hand.first} vs #{hand.last} - #{message % [hand.first, hand.last]}" do
			allow(input_stream).to receive(:gets).and_return(hand.first)
			allow(subject).to receive(:generate_computer_option).and_return(hand.last)
			
			subject.play
			expect(output_stream.string).to include(message % [hand.first, hand.last])
		end
	end
end