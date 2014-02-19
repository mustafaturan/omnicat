require 'omnicat'

module OmniCat
  module Classifiers
    module StrategyInternals
      class Category < ::OmniCat::Base
        attr_accessor :doc_count, :docs, :name, :token_count, :tokens

        def initialize(category_hash = {})
          @doc_count = category_hash[:doc_count].to_i
          @docs = category_hash[:docs] || {}
          @name = category_hash[:name] || nil
          @tokens = category_hash[:tokens] || {}
          @token_count = category_hash[:token_count].to_i
        end
      end
    end
  end
end