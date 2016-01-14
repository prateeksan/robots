class BoxOfBolts < Item

  HEALING_POINTS = 20

  def initialize
    @name = "Box of bolts"
    @weight = 25
  end

  def feed(consumer)
    consumer.heal(HEALING_POINTS)
  end 
end