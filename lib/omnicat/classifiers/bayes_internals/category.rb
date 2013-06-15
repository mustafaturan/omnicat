module OmniCat
  module Classifiers
    module BayesInternals
      class Category < ::OmniCat::Base
        attr_accessor :doc_count, :tokens, :token_count

        def initialize(category_hash = {})
          self.doc_count = category_hash[:doc_count].to_i
          self.tokens = category_hash[:tokens] || {}
          self.token_count = category_hash[:token_count].to_i
        end
      end
    end
  end
end