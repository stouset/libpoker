require File.dirname(__FILE__) + '/../../spec_helper'

describe Array do
  before(:each) do
    @array = (1..1000).to_a
  end
  
  describe 'when shuffled' do
    it 'should be randomized' do
      @array.shuffle.should_not == @array
    end
    
    it 'should contain the same contents' do
      @array.shuffle.sort.should == @array.sort
    end
  end
  
  describe 'when shuffled!' do
    # technically internal functionality, but this spec ensures that
    # Array#shuffle! should abide by all the same specs as Array#shuffle
    it 'should rely on Array#shuffle' do
      @array.should_receive(:shuffle).and_return []
      @array.shuffle!
    end
      
    
    it 'should modify the original' do
      @array.shuffle!.should eql(@array)
    end
  end
end