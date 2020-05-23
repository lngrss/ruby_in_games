require './board'
require './player'
require './game'

board = Board.new(7)
board.make_move(3, '#')
board.make_move(3, '+')
board.make_move(3, '+')
board.make_move(0, '#')
board.make_move(6, '#')

player_1 = Player.new('John', 'o')
player_2 = Player.new('Mindy', 'x')

game = Game.new(player_1, player_2)
game.play
