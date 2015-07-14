require 'spec_helper'

describe Game do

	subject(:game) { described_class.new }

	let(:description) do |example|
		example.description
	end

	describe '#evaluate' do

		context 'when the choices are different' do
			it 'paper beats rock' do
				expect(game.evaluate('paper', 'rock')).to eq(description)
			end

			it 'scissors beats paper' do
				expect(game.evaluate('scissors', 'paper')).to eq(description)
			end

			it 'rock beats scissors' do
				expect(game.evaluate('rock', 'scissors')).to eq(description)
			end
		end

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
				expect(game.capture_option).to eq('paper')
			end
		end
	end
end