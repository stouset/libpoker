class Array
  #
  # Randomizes the contents of the Array, replacing the existing Array with
  # the shuffled one.
  #
  def shuffle!
    replace(shuffle)
  end
  
  #
  # Returns a new Array with the shuffled contents of the original.
  #
  def shuffle
    sort_by { rand }
  end
end