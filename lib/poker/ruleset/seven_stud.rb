module Poker
  module Ruleset
    class SevenStud < Poker::Rules
      street :open,    [ :deal ] * 3
      street :fourth,  [ :deal ]
      street :fifth,   [ :deal ]
      street :sixth,   [ :deal ]
      street :seventh, [ :deal ]
            
      order   :high_hand
      upcards 0b0011110
    end
  end
end