require 'spec_helper'
require 'pry'

describe Game do

	it 'uses stdin as the default input reader' do
		expect(subject.input).to eq($stdin)
	end

	it 'uses stdout as the default output renderer' do
		expect(subject.output).to eq($stdout)
	end	

	describe '#play' do
	
		let(:game_instructions) { "Pick your poison; rock, paper or scissors" }

		let(:output_stream) { StringIO.new }
		let(:input_stream) { StringIO.new }

		subject(:game) { described_class.new(input_stream, output_stream) }

		it 'displays the instructions' do
			allow(game).to receive(:decide)
			allow(game).to receive(:capture_user_option)

			game.play
			expect(output_stream.string).to start_with(game_instructions)
		end

		it 'captures a valid game option' do
			allow(game).to receive(:decide)
			allow(input_stream).to receive(:gets).and_return('paper')

			game.play
			expect(game.user_option).to eq('paper')
		end

		it 'rejects invalid game options' do
			allow(game).to receive(:display_instructions)
			allow(input_stream).to receive(:gets).and_return('brick')
			allow(subject).to receive(:generate_computer_option).and_return('paper')
			allow(game).to receive(:decide)

			game.play
			expect(game.user_option).to eq('paper')
			expect(output_stream.string).to include("Come on, play the game 'brick' was not an option. We have generated an option for you.")
		end

		it 'generates an option for the computer' do
			allow(game).to receive(:decide)
			allow(game).to receive(:capture_user_option)

			game.play
			expect(['rock', 'paper', 'scissors']).to include(game.computer_option) 
		end

		context 'user wins' do
			winning_hands = [
				['rock','scissors'],
				['scissors', 'paper'],
				['paper', 'rock']
			]

			it_behaves_like 'a hand is played', winning_hands, Game::MESSAGES[:win]
		end

		context 'computer wins' do
			losing_hands = [
				['paper','scissors'],
				['scissors', 'rock'],
				['rock', 'paper']
			]

			it_behaves_like 'a hand is played', losing_hands, Game::MESSAGES[:lose]
		end

		context "it's a draw" do
			drawing_hands = [
				['paper','paper'],
				['scissors', 'scissors'],
				['rock', 'rock']
			]

			it_behaves_like 'a hand is played', drawing_hands, Game::MESSAGES[:draw]
		end
	end
end