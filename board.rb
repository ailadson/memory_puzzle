require './card.rb'

class Board

  ALPHABET = ("A".."Z").to_a
  attr_reader :grid

  def initialize(size)
    @grid = Array.new(size*2) { Array.new(size*2) }
    populate
  end

  def populate
    alpha_idx = 0
    size = @grid.length/2
    (0..size-1).each do |row|
      (0..size*2-1).each do |col|
        @grid[row*2][col] = Card.new(ALPHABET[alpha_idx])
        @grid[row*2+1][col] = Card.new(ALPHABET[alpha_idx])
        if alpha_idx < 25
          alpha_idx += 1
        else
          alpha_idx = 0
        end
      end
    end
    shuffle
  end

  def render
    system("clear")
    @grid.length.times do |i|
      print "|#{i}|"
    end
    puts ""

    @grid.each_with_index do |row, idx|
      row_string = ""
      row.each do |col|
        row_string << col.to_s
      end
      row_string << " |#{idx}|"
      puts row_string
    end
  end

  def won?
    @grid.all? { |row| row.all? { |card| !card.face_down } }
  end

  def reveal(guessed_pos)
    idx1, idx2 = guessed_pos
    card = @grid[idx1][idx2]
    card.reveal
  end

  def hide(guessed_pos)
    #p "Checking guessed_pos: #{guessed_pos}"
    idx1, idx2 = guessed_pos
    card = @grid[idx1][idx2]
    card.hide
  end

  private
  def shuffle
    @grid = @grid.shuffle.transpose.shuffle
  end

end

if __FILE__ == $PROGRAM_NAME
  board = Board.new(5)
  board.populate
  board.render
  board.reveal([1,3])
  board.reveal([0,4])
  board.render
end
