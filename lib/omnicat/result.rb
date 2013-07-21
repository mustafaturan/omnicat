require File.dirname(__FILE__) + '/base'

module OmniCat
  class Result < ::OmniCat::Base
    attr_accessor :scores

    def initialize
      @top_score_key = nil
      @scores = {}
      @total_score = 0
    end

    # Method for adding new score to result
    #
    # ==== Parameters
    #
    # * +score+ - OmniCat::Score
    #
    def add_score(score)
      @total_score += score.value
      @scores[score.key] = score
      if @top_score_key.nil? || @scores[@top_score_key].value < score.value
        @top_score_key = score.key
      end
    end

    # Method for getting highest ranked score
    #
    # ==== Returns
    #
    # * +score+ - OmniCat::Score
    #
    def top_score
      @scores[@top_score_key]
    end

    # Method for calculating percentages for scores
    #
    def calculate_percentages
      @scores.each do |key, score|
        @scores[key].percentage = percentage(score.value)
      end
    end

    private
      attr_reader :top_score_key, :total_score

      # nodoc
      def percentage(value)
        (value * 100.0 / @total_score).round(0)
      end
  end
end