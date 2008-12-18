module Poker
  class Player
    attr_accessor :name
    attr_accessor :stack
    
    #
    # Instantiate a new player with a name and stack size.
    #
    def initialize(name, stack)
      self.name  = name
      self.stack = stack
    end
    
    def act(game)
      raise NotImplementedError, 'Subclasses must implement Player#act'
    end
  end
end