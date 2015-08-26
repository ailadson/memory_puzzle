require 'byebug'

class ComputerPlayer
  def initialize(board)
    @matches = Hash.new() { |h,k| h[k] = [] }
    @revealed = []
    @board = board
    @next_match
  end

  def alert_correct(guess, val)
    @revealed << guess
    @matches[val] -= guess
  end

  def alert_incorrect(guess, value)
    @matches[value] << guess
    @matches[value].uniq!
  end

  def get_guess
    unless @next_match.nil?
      temp = @next_match
      @next_match = nil
      return temp
    end

    matches = find_matches

    if matches.empty?
      unrevealed = []
      @board.grid.each_with_index do |row, idx1|
        row.each_with_index do |card, idx2|
          unrevealed << [idx1, idx2] if card.face_down
        end
      end

      return unrevealed.sample
    else
      val = @board.grid[matches[0][0]][matches[0][1]].value
      val = "{#{val}}"
      @next_match = @matches[val].pop
      return @matches[val].pop
    end
  end

  def find_matches
    @matches.each do |k, v|
      return v if v.length > 1
    end
    []
  end
end
