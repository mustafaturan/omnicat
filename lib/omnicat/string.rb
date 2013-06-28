# encoding: UTF-8
class String
  def omnicat_tokenize
    self.scan(/[\p{L}\-0-9]{2,}/) + self.scan(/[\!\?]/) +
    self.scan(/[\:\)\(\;\-\|]{2,3}/) -
    self.scan(/(@[\w\d]+)/).collect{ |str_arr| str_arr.first.gsub('@', '') }
  end

  def tokenize_with_counts
    self.omnicat_tokenize.hashify_with_counts
  end
end