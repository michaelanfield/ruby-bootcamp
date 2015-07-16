shared_examples 'a drawing hand' do |hands|

	hands.each do |hand| 
		it "says the draw message - #{hand.first} draws with #{hand.last}" do
			allow(input_stream).to receive(:gets).and_return(hand.first)
			allow(subject).to receive(:generate_computer_option).and_return(hand.last)
			
			subject.play
			expect(output_stream.string).to include("Oooo, it's a draw")
		end
	end
end