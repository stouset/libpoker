require 'core_ext/array/shuffle'

module Poker
  #
  # A representation of a standard 52-card deck of poker cards. Cards are
  # lightweight, represented simply by a String containing the traditional
  # card nomenclature. The Ace of spades is represented by 'As', and the seven
  # of clubs is represented by '7c'.
  #
  class Deck
    RANKS = %w{ A K Q J T 9 8 7 6 5 4 3 2 }
    SUITS = %w{ s d c h }
    
    #
    # The unshuffled set of cards that comprise a deck. This is a performance
    # optimization so generating new decks is fast.
    #
    CARDS = RANKS.collect {|r| SUITS.collect {|s| r + s } }.flatten
    
    #
    # The list of cards still in the deck.
    #
    attr_accessor :cards
    
    #
    # Returns a new, unshuffled deck.
    #
    def self.unshuffled
      new
    end
    
    #
    # Returns a new, shuffled deck.
    #
    def self.shuffled
      new.shuffle!
    end
    
    #
    # Initializes the deck with 52 cards, unshuffled.
    #
    def initialize
      reset!
    end
    
    #
    # Indexes into the cards in the deck.
    #
    def [](index)
      cards[index]
    end
    
    #
    # Removes the top card from the deck. Raises an ArgumentError if the deck
    # is empty.
    #
    def deal
      raise ArgumentError, 'no cards left to deal' if empty?
      
      cards.shift
    end
    
    #
    # Resets the deck to its initial, 52-card, unshuffled state.
    #
    def reset!
      self.cards = CARDS.dup
    end
    
    #
    # Randomizes the order of the cards in the deck.
    #
    def shuffle!
      self.cards.shuffle!
      self
    end
    
    #
    # The number of cards remaining in the deck.
    #
    def length
      cards.length
    end
    
    #
    # The first card in the deck.
    #
    def top
      cards.first
    end
    
    #
    # Returns true if the deck contains all its original cards.
    #
    def full?
      self.length == CARDS.length
    end
    
    #
    # Returns true if the deck contains no more cards.
    #
    def empty?
      self.length == 0
    end
  end
end