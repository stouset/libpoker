module Poker
  module Ruleset
    class HoldEm
      include Poker::Rules
      
      round :preflop, [ :deal ] * 2
      round :flop,    [ :community ] * 3
      round :turn,    [ :community ]
      round :river,   [ :community ]
      
      before :preflop   => :post,
      
      burn!
      limits
      order :button
    end
  end
end