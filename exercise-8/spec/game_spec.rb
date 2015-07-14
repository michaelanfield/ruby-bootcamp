require 'spec_helper'

describe Game do

	let(:description) do |example|
		example.description
	end

	describe '#evaluate' do

		subject(:game) { Game.new }

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
end