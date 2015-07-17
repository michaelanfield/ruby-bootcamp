require 'pry'

describe Exercise9::Person do

	subject { described_class.new('Bob') }

	it_behaves_like Exercise9::Speech, ['HeLLo', 'wOrld']
	it_behaves_like Exercise9::Moveable

	context '#tell_me_the_time' do
		
		let(:greeting_msg) { 'Yo' }

		it "but I don't have a watch" do
			$stdout.rewind

			allow(subject).to receive(:greeting).and_return(greeting_msg)

			subject.tell_me_the_time

			expect($stdout.string).to include("#{greeting_msg}, sorry I'm not a Robot and I don't have a watch".downcase)
		end
	end
end