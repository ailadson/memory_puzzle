require './board.rb'
require './humanplayer.rb'
require './computerplayer.rb'


class Game
  def initialize
    setup_board
    setup_player
  end

  def play
    until @board.won?
      play_round
    end

    @board.render
    puts "You've won the game!"
  end

  private
  def setup_player
    puts "Do you want to watch an AI play?(Y/n)"
    response = gets.chomp

    until response == "Y" || response == "n"
      puts "Do you want to watch an AI play?(Y/n)"
      response = gets.chomp
    end

    if response == "Y"
      @player = ComputerPlayer.new(@board)
    else
      @player = HumanPlayer.new(@board)
    end
  end

  def setup_board
    puts "Welcome to Memory!  Choose a size between 1 and 13."
    size = gets.chomp.to_i
    @board = Board.new(size)
  end

  def play_round
    guess1, value1 = handle_guess(1)
    guess2, value2 = handle_guess(2)
    @board.render
    if value1 == value2
      puts "You guessed right!"
      @player.alert_correct(guess1, value1)
      @player.alert_correct(guess2, value2)
    else
      puts "You guessed wrong!"
      @player.alert_incorrect(guess1, value1)
      @player.alert_incorrect(guess2, value2)
      @board.hide(guess1)
      @board.hide(guess2)
    end
    sleep(1)
  end

  def handle_guess(num)
    @board.render
    guess = @player.get_guess
    puts "Guess #{num}: #{guess}"
    sleep(1)
    value = @board.reveal(guess)
    [guess, value]
  end

end


game = Game.new
puts game.play
