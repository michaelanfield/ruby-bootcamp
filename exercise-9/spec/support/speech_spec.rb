shared_examples_for Exercise9::Speech do |words|

	specify { expect(subject).to be_a_kind_of Exercise9::Speech }

	before(:each) do
		$stdout = StringIO.new
	end

	describe '#say' do
		words.each do |word|
			it "displays #{word} in lowercase" do
				subject.say word
				expect($stdout.string).to include("#{word.downcase}")
			end
		end
	end

	describe '#shout' do
		words.each do |word|
			it "displays #{word} in uppercase with exclamations" do
				subject.shout word
				expect($stdout.string).to include("#{Exercise9::Speech::SHOUT_MSG % word.upcase}")
			end
		end
	end
end