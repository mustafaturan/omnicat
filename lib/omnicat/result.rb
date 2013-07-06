require 'omnicat'

module OmniCat
  class Result < ::OmniCat::Base
    attr_accessor :category, :scores, :total_score

    def initialize
      self.category = {}
      self.scores = {}
      self.total_score = 0
    end
  end
end