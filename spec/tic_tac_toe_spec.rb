# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/tic_tac_toe'

describe Game do
  let(:game) { described_class.new }

  describe '#valid_move?' do
    it 'returns false if the position is out of bounds' do
      expect(game.valid_move?(-1)).to be false
      expect(game.valid_move?(9)).to be false
    end

    it 'returns false if the position is already occupied' do
      game.make_move(0)
      expect(game.valid_move?(0)).to be false
    end

    it 'returns true if the position is within bounds and not occupied' do
      expect(game.valid_move?(0)).to be true
    end
  end

  describe '#make_move' do
    it 'raises an error if the move is invalid' do
      game.make_move(0)
      expect { game.make_move(0) }.to raise_error(RuntimeError)
    end

    it 'makes a move if the move is valid' do
      game.make_move(0)
      expect(game.instance_variable_get(:@board)[0]).not_to eq(described_class::EMPTY_CELL)
    end
  end

  describe '#game_over?' do
    it 'returns the winner if there is one' do
      game.make_move(0) # X
      game.make_move(3) # O
      game.make_move(1) # X
      game.make_move(4) # O
      game.make_move(2) # X
      expect(game.game_over?).to eq(described_class::PLAYER_X)
    end

    it 'returns "Draw" if the board is full and there is no winner' do
      [0, 1, 2, 3, 4, 5, 6, 7, 8].each { |i| game.make_move(i) }
      expect(game.game_over?).to eq('Draw')
    end
  end

  describe '#play' do
    it 'plays a game' do
      allow_any_instance_of(described_class).to receive(:gets).and_return('0', '1', '2', '3', '4', '5', '7', '6', '8')
      game.play
      expect(game.game_over?).to eq('Draw')
    end
  end
end
