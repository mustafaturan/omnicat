require File.dirname(__FILE__) + '/base'

module OmniCat
  class Result < ::OmniCat::Base
    attr_accessor :scores

    def initialize
      @top_score_key = nil
      @scores = {}
      @total_score = 0
    end

    def add_score(score)
      @total_score += score.value
      @scores[score.key] = score
      if @top_score_key.nil? || @scores[@top_score_key].value < score.value
        @top_score_key = score.key
      end
    end

    def top_score
      @scores[@top_score_key]
    end

    def calculate_percentages
      @scores.each do |key, score|
        @scores[key].percentage = percentage(score.value)
      end
    end

    private
      attr_reader :top_score_key, :total_score

      def percentage(value)
        (value * 100.0 / @total_score).round(0)
      end
  end
end