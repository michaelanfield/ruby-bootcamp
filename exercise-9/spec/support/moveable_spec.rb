shared_examples_for Exercise9::Moveable do

	specify { expect(subject).to be_a_kind_of Exercise9::Moveable }

	shared_examples 'it takes directions' do |direction_and_outcomes|
		direction_and_outcomes.each do |direction, outcome|
			it "will #{direction} resulting in #{outcome}" do
				entity = subject.send(direction)

				expect(entity.position).to eq(outcome)
			end
		end
	end

	it_behaves_like 'it takes directions', {
		:move_left => {logitude: 0, lattitude: 1},
		:move_right => {logitude: 0, lattitude: -1},
		:move_forwards => {logitude: 1, lattitude: 0},
		:move_backwards => {logitude: -1, lattitude: 0}
	}

	it "does not move :all_over_the_shop" do
		expect { subject.send(:move, :all_over_the_shop) }.to raise_error(Exercise9::Moveable::InvalidDirectionException)
		expect(subject.position).to eq({logitude: 0, lattitude: 0})
	end
end