# frozen_string_literal: true

require 'rspec'
require_relative 'spec_helper'
require_relative '../lib/tic-tac-toe'

describe Game do
  let(:game) { Game.new }

  describe '#valid_move?' do
    it 'returns false if the position is out of bounds' do
      expect(game.valid_move?(-1)).to eq(false)
      expect(game.valid_move?(9)).to eq(false)
    end

    it 'returns false if the position is already occupied' do
      game.make_move(0)
      expect(game.valid_move?(0)).to eq(false)
    end

    it 'returns true if the position is within bounds and not occupied' do
      expect(game.valid_move?(0)).to eq(true)
    end
  end

  describe '#make_move' do
    it 'raises an error if the move is invalid' do
      game.make_move(0)
      expect { game.make_move(0) }.to raise_error(RuntimeError)
    end

    it 'makes a move if the move is valid' do
      game.make_move(0)
      expect(game.instance_variable_get(:@board)[0]).not_to eq(Game::EMPTY_CELL)
    end
  end

  describe '#game_over?' do
    it 'returns the winner if there is one' do
      game.make_move(0)
      game.make_move(3)
      game.make_move(1)
      game.make_move(4)
      game.make_move(2)
      expect(game.game_over?).to eq(Game::PLAYER_O)
    end

    it 'returns "Draw" if the board is full and there is no winner' do
      [0, 1, 2, 3, 4, 6, 5, 7, 8].each { |i| game.make_move(i) }
      expect(game.game_over?).to eq('Draw')
    end

    it 'returns nil if the game is not over' do
      expect(game.game_over?).to eq(nil)
    end
  end
end
