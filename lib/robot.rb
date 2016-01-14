require 'pry'
class Robot

  attr_reader :position, :items, :health
  attr_accessor :equipped_weapon

  WEAK_HIT = 5
  MAX_WEIGHT = 250
  MAX_HP = 100
  MIN_HP = 0

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
  end

  def attack(enemy)
    attack!(enemy)
    return false unless enemy_in_range?(enemy)
    if equipped_weapon
      equipped_weapon.hit(enemy)
      self.equipped_weapon = nil if equipped_weapon.is_a? Grenade
      return true  
    else
      enemy.wound(WEAK_HIT) if enemy.is_a? Robot
    end
  end

  def heal!(heal_points)
      raise RobotAlreadyDeadError.new "HP is already 0, robots can't be revived" if @health <= MIN_HP
  end

  def attack!(enemy)
      raise UnattackableEnemy.new "Can only attack robots" unless enemy.is_a? Robot 
  end

  def wound(attack_power)
    health - attack_power >= MIN_HP ? @health -= attack_power : @health = MIN_HP
  end

  def heal(heal_points)
    heal!(heal_points)
    health + heal_points <= MAX_HP ? @health += heal_points : @health = MAX_HP
  end

  def items_weight
    items_weight = 0
    @items.each do |item|
      items_weight += item.weight 
    end
    items_weight
  end

  def pick_up(item)
    return false unless items_weight + item.weight <= MAX_WEIGHT 
    self.equipped_weapon = item if item.is_a? Weapon
    item.feed(self) if item.is_a?(BoxOfBolts) && self.health <= 80
    @items << item
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  private

  def enemy_in_range?(enemy)
    x_axis_difference = (self.position[0] - enemy.position[0]).abs
    y_axis_difference = (self.position[1] - enemy.position[1]).abs
    acceptable_coordinate_differences = [0,1]
    acceptable_coordinate_differences << 2 if equipped_weapon.is_a? Grenade
    acceptable_coordinate_differences.include?(x_axis_difference) && acceptable_coordinate_differences.include?(y_axis_difference)
  end

end
