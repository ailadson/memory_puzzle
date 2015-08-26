class Card
  attr_reader :value, :face_down

  def initialize(value)
    @value = value
    @face_down = true
  end

  def hide
    @face_down = true
  end

  def reveal
    @face_down = false
    to_s
  end

  def to_s
    @face_down ? "{_}" :  "{"+@value.to_s+"}"
  end

  def ==(card)
    @value == card.value
  end
end
