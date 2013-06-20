# encoding: UTF-8
class String
  def omnicat_tokenize
    self.scan(/[\p{L}\-0-9]{2,}/) + self.scan(/[\!\?]/) +
    self.scan(/[\:\)\(\;\-\|]{2,3}/)
  end

  def tokenize_with_counts
    self.omnicat_tokenize.hashify_with_counts
  end
end