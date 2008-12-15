require 'poker/deck'

describe Poker::Deck do
  describe 'unshuffled' do
    before(:each) do
      @deck = Poker::Deck.unshuffled
    end
    
    it 'should contain all the cards in order' do
      @deck.cards.should == Poker::Deck::CARDS
    end
    
    it 'should randomize its cards when shuffled' do
      @deck.cards.should_receive(:shuffle!)
      @deck.shuffle!
    end
  end
  
  describe 'shuffled' do
    before(:each) do
      @deck = Poker::Deck.shuffled
    end
    
    it 'should not be in order' do
      @deck.cards.should_not  == Poker::Deck::CARDS
      @deck.cards.sort.should == Poker::Deck::CARDS.sort
    end
    
    it 'should contain all 52 cards' do
      @deck.length.should == 52
    end
    
    it 'should be full' do
      @deck.should be_full
    end
    
    it 'should return itself when shuffled' do
      @deck.shuffle!.should == @deck
    end
    
    it 'should deal the first card in the deck' do
      @deck.cards.first.should == @deck.deal
    end
    
    it 'should remove a card from the top when dealing' do
      lambda { @deck.deal }.should change(@deck, :top).to(@deck[1])
    end
  end
  
  describe 'after dealing' do
    before(:each) do
      @deck = Poker::Deck.shuffled
      @deck.deal
    end
    
    it 'should not be full' do
      @deck.should_not be_full
    end
  end
  
  describe 'when empty' do
    before(:each) do
      @deck = Poker::Deck.shuffled
      @deck.deal until @deck.empty?
    end
    
    it 'should be empty' do
      @deck.should be_empty
    end
    
    it 'should raise an exception when trying to deal' do
      lambda { @deck.deal }.should raise_error(ArgumentError)
    end
  end
end