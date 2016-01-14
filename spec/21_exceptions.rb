require 'spec_helper'

describe Robot do 
  before :each do
    @robot = Robot.new
  end

  describe "#heal!" do
    it "Should raise error if a heal is attempted on a robot with 0 health or less" do 
      @robot.wound(100)
      expect{@robot.heal!(20)}.to raise_error(RobotAlreadyDeadError)
    end
  end

  describe "#attack!" do
    it "Should raise error if user attacks an item that isnt a robot" do
      @plasma_cannon = PlasmaCannon.new
      expect{@robot.attack!(@plasma_cannon)}.to raise_error(UnattackableEnemy)
    end
  end
end