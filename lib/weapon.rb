class Weapon < Item

  attr_reader :damage

  DEFAULT_DAMAGE = 45

  def initialize(name, weight, damage)
    super(name, weight)
    @damage = damage
  end

  def hit(enemy)
    enemy.wound(DEFAULT_DAMAGE)
  end

end