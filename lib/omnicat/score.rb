require File.dirname(__FILE__) + '/base'

module OmniCat
  class Score < ::OmniCat::Base
    attr_accessor :key
    attr_accessor :value
    attr_accessor :percentage

    def initialize(score_hash = {})
      @key = score_hash[:key]
      @value = score_hash[:value]
      @percentage = score_hash[:percentage] || 0
    end
  end
end