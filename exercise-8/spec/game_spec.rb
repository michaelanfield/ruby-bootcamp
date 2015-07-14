require 'spec_helper'
require 'pry'

describe Game do

	subject(:game) { described_class.new }

	let(:description) do |example|
		example.description
	end

	describe '#evaluate' do
		context 'when the choices are the same' do
			it "it's a draw" do
				expect(game.evaluate('rock', 'rock')).to eq(description)
			end
		end
	end

	describe '#capture_option' do

		before do
			allow(game).to receive(:gets).and_return('paper')
		end

		let(:capture_message) { "Pick your poison; rock, paper or scissors\n" }

		context 'when the game is started' do
			it 'prompts for user with instructions' do
				expect {game.capture_option}.to output(capture_message).to_stdout
			end

			it 'captures the option supplied' do
				allow(game).to receive(:puts)
				expect(game.capture_option).to eq('paper')
			end
		end
	end

	describe '#play' do

		context 'when the user option is supplied we will display a winning message' do

			it 'paper beats rock' do
				allow(game).to receive(:capture_option).and_return('paper')
				allow(game).to receive(:random_option).and_return('scissors')

				expect {game.play}.to output(description + "\n").to_stdout
			end

			it 'scissors beats paper' do
				allow(game).to receive(:capture_option).and_return('scissors')
				expect {game.play}.to output(description + "\n").to_stdout
			end

			it 'rock beats scissors' do
				allow(game).to receive(:capture_option).and_return('rock')
				expect {game.play}.to output(description + "\n").to_stdout
			end
		end
	end
end