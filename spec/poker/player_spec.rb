require File.dirname(__FILE__) + '/../spec_helper'

describe Poker::Player do
  before(:each) do
    @name   = 'Player 1'
    @stack  = 500
    
    @player = Poker::Player.new(@name, @stack)
  end
  
  it 'should provide the player name' do
    @player.name.should == @name
  end
  
  it 'should provide the stack size' do
    @player.stack.should == @stack
  end
  
  it 'should raise NotImplementedError on calling #act' do
    lambda { @player.act(nil) }.should raise_error(NotImplementedError)
  end
end