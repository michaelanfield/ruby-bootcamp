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

			game.play
			expect(output_stream.string).to start_with(game_instructions)
		end

		it 'captures a game option' do
			allow(game).to receive(:decide)
			allow(input_stream).to receive(:gets).and_return('paper')

			game.play
			expect(game.user_option).to eq('paper')
		end

		it 'generates an option for the computer' do
			allow(game).to receive(:decide)

			game.play
			expect(['rock', 'paper', 'scissors']).to include(game.computer_option) 
		end

		context 'user wins' do

			winning_hands = [
				['rock','scissors'],
				['scissors', 'paper'],
				['paper', 'rock']
			]

			winning_hands.each do |options|
				it "says the winning message - #{options.first} beats #{options.last}" do
					allow(input_stream).to receive(:gets).and_return(options.first)
					allow(game).to receive(:generate_computer_option).and_return(options.last)
					
					game.play
					expect(output_stream.string).to include("#{options.first} beats #{options.last}")
				end
			end
		end

		context 'computer wins' do
			it 'says the losing message' do
				allow(input_stream).to receive(:gets).and_return('paper')
				allow(game).to receive(:generate_computer_option).and_return('scissors')
				
				game.play
				expect(output_stream.string).to include('paper loses to scissors')
			end
		end

		context "it's a draw" do
			it 'says the draw message' do
				allow(input_stream).to receive(:gets).and_return('scissors')
				allow(game).to receive(:generate_computer_option).and_return('scissors')
				
				game.play
				expect(output_stream.string).to include("Oooo, it's a draw")
			end
		end
	end
end