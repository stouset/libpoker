module Poker
  module Ruleset
    class SevenStud < Poker::Rules
      round :open,    [ :deal ] * 3
      round :fourth,  [ :deal ]
      round :fifth,   [ :deal ]
      round :sixth,   [ :deal ]
      round :seventh, [ :deal ]
            
      order   :high_hand
      upcards 0b0011110
    end
  end
end