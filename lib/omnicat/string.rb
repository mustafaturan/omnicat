class String
  def omnicat_tokenize
    self.scan(/([\p{L}\-0-9]{2,})/).collect{ |str_arr| str_arr.first }
  end

  def tokenize_with_counts
    self.omnicat_tokenize.hashify_with_counts
  end
end