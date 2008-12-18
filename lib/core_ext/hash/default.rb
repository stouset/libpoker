class Hash
  #
  # Creates a new Hash where the default value of each key is the value
  # returned by the block passed. Keys are automatically assigned their
  # default values when used.
  #
  def self.default(&block)
    Hash.new {|h,k| h[k] = block.call(k) }
  end
end