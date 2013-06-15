class Array
  def hashify_with_counts
    hash = {}
    self.each do |item|
      hash[item] = hash.has_key?(item) ? (hash[item] + 1) : 1
    end
    hash
  end
end