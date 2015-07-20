require 'pry'

describe Exercise9::Robot do

	subject { described_class.new('Tin man') }

	it_behaves_like Exercise9::Speech, ['HeLLo', 'wOrld']
	it_behaves_like Exercise9::Moveable

	context '#tell_me_the_time' do
		
		let(:greeting_msg) { 'How do' }
		let(:time) { Time.now }

		it "display the time" do
			$stdout.rewind

			allow(subject).to receive(:greeting).and_return(greeting_msg)
			allow(Time).to receive(:now).and_return(time)

			subject.tell_me_the_time

			expect($stdout.string).to include((Exercise9::Robot::GREETING_MSG % [greeting_msg, time]).downcase)
		end
	end

	context '#fire_laser' do
		it 'will fire the laser' do
			$stdout.rewind

			subject.fire_laser
			expect($stdout.string).to include(Exercise9::Robot::FIRE_LASER_MSG.upcase)
		end
	end
end