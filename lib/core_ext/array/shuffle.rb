class Array
  unless respond_to?(:shuffle!)
    #
    # Randomizes the contents of the Array, replacing the existing Array with
    # the shuffled one.
    #
    def shuffle!
      replace(shuffle)
    end
  end
  
  unless respond_to?(:shuffle)
    #
    # Returns a new Array with the shuffled contents of the original.
    #
    def shuffle
      sort_by { rand }
    end
  end
end