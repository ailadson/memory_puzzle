class HumanPlayer
  def initialize(board)
    @board = board
    @revealed = []
  end

  def get_guess(previous_guess = nil)
    guess = [prompt("row"), prompt("column")]
    valid = false
    until valid
      if (previous_guess && previous_guess == guess) && @revealed.include?(guess)
        puts "You've entered a duplicate guess.  Try again."
        guess = [prompt("row"), prompt("column")]
      else
        valid = true
      end
    end
    guess
  end

  def alert_correct(guess, _)
    @revealed << guess
  end

  def alert_incorrect(guess, value)
  end

  def prompt(type)
    valid = false
    until valid
      print "Guess the #{type}: "
      guess = gets.chomp.to_i
      if guess >= @board.grid.length
        puts "Invalid #{type}."
      else
        valid = true
      end
    end
    guess
  end

end
