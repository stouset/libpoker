module Poker
  class Game
    attr_accessor :table
    attr_accessor :ruleset
    attr_accessor :limit
    attr_accessor :blinds
    
    #
    # Creates a new instance of a poker game. Accepts hash parameters to
    # specify the +table+, +ruleset+, +limit+ type, and +blinds+ structure.
    # Yields +self+ to an initialization block as well.
    #
    #   Poker::Game.new do |game|
    #     game.table   = Poker::Table.new(6)
    #     game.ruleset = Poker::Ruleset::HoldEm
    #     game.limit   = Poker::Limit::NoLimit
    #     game.blinds  = [25, 50]
    #   end
    #
    def initialize(options = {})
      self.table   = options[:table]
      self.ruleset = options[:ruleset]
      self.limit   = options[:limit]
      self.blinds  = options[:blinds]
      
      # preallocate the state flag
      self.flag = Flag.new
      
      # pass self for further initialization
      yield(self) if block_given?
    end
    
    #
    # Begins the main poker loop in another thread. Runs asynchronously
    # until the game is stopped. Yields +self+ to the block passed between
    # each hand of play. Play continues until the block or another thread
    # stops the game.
    #
    # Raises a ThreadError if the game has already been started.
    #
    def play(&intermission)
      raise ThreadError if started?
      
      synchronize(:thread) do
        self.thread = Thread.new do
          # wait on the thread assignment before freezing, and freeze because
          # we don't want to allow the game to change mid-play
          #
          # TODO: should ruleset, limit, and blinds be frozen too?
          synchronize(:thread) { self.freeze }
          
          run(&intermission)
        end
      end
    end
    
    #
    # Schedules the game to be terminated at the end of the current hand.
    #
    def stop
      self.flag.stopped!
    end
    
    #
    # Returns true if the game has been started (by calling play). Will still
    # return true once the game has been stopped. Games may not be re-started
    # due to being frozen once begun.
    #
    # NOTE: Is there any way around that?
    #
    def started?
      not synchronize(:thread) { self.thread }.nil?
    end
    
    protected
    
    #
    # Simple flag-state class. We freeze the Game when begun, so we need a
    # class capable of encapsulating a state flag that lets us know when to
    # stop the game.
    #
    #   f = Flag.new
    #   f.foo? #=> false
    #   f.bar? #=> false
    #   f.foo!
    #   f.foo? #=> true
    #   f.bar? #=> false
    #   f.bar!
    #   f.foo? #=> false
    #   f.bar? #=> true
    #
    Flag = Struct.new(:value) do
      def method_missing(name, *args)
        case name.to_s
          when %r{ (.*)!$  }x then self.value =  $1.to_sym
          when %r{ (.*)\?$ }x then self.value == $1.to_sym
          else                     super
        end
      end
    end
    
    attr_accessor :thread
    attr_accessor :flag
    
    #
    # Synchronizes the block using a semaphore identified by +name+.
    #
    def synchronize(name, &block)
      @semaphores ||= Hash.new {|h,k| h[k] = Mutex.new }
      @semaphores[name.to_sym].synchronize(&block)
    end
    
    #
    # The main game loop. Loops until the game is stopped in the main thread
    # or in the intermission block.
    #
    def run
      until self.flag.stopped?
        # TODO: game logic
        sleep 5
          
        # allow code to run between each hand dealt
        yield(self) if block_given?
      end
    end
  end
end