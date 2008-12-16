module Poker
  module Ruleset
    class HoldEm
      include Poker::Rules
      
      street :preflop, [ :deal ] * 2
      street :flop,    [ :community ] * 3
      street :turn,    [ :community ]
      street :river,   [ :community ]
      
      before :preflop   => :post,
             :turn      => :raise_limits
      
      burn!
      order :button
    end
  end
end