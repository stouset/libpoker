class Hash
  def self.default(&block)
    Hash.new {|h,k| h[k] = block.call(k) }
  end
end