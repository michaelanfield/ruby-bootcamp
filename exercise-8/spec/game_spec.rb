require 'spec_helper'

describe Game do
	describe '#evaluate' do

		subject(:game) { Game.new }

		context 'when the choices are different' do
			it 'paper beats rock' do
				expect(game.evaluate('paper', 'rock')).to eq('paper beats rock')
			end

			it 'scissors beats paper' do
				expect(game.evaluate('scissors', 'paper')).to eq('scissors beats paper')
			end

			it 'rock beats scissors' do
				expect(game.evaluate('rock', 'scissors')).to eq('rock beats scissors')
			end
		end

		context 'when the choices are the same' do
			it "it's a draw" do
				expect(game.evaluate('rock', 'rock')).to eq("it's a draw")
			end
		end
	end
end