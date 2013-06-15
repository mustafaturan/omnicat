module OmniCat
  module Classifiers
    class Base < ::OmniCat::Base
      # Allows adding multiple classification categories
      #
      # ==== Parameters
      #
      # * +names+ - Array of categories
      #
      # ==== Examples
      #
      #   # Add multiple categories for classification
      #   bayes.add_categories(["positive", "negative", "neutral"])
      def add_categories(names)
        names.each { |name| add_category(name) }
      end

      # Train the desired category with multiple documents
      #
      # ==== Parameters
      #
      # * +category+ - Name of the category from added categories list
      # * +docs+ - Array of documents
      #
      # ==== Examples
      #
      #   # Add multiple docs for training the category
      #   bayes.train("positive", ["clear documentation", "good, very well"])
      #   bayes.train("negative", ["bad interface", "damn"])
      def train_batch(category, docs)
        docs.each { |doc| train(category, doc) }
      end

      # Classify the multiple documents at a time
      #
      # ==== Parameters
      #
      # * +docs+ - Array of documents
      #
      # ==== Returns
      #
      # * +result_set+ - Array of OmniCat::Result objects
      #
      # ==== Examples
      #
      #   # Classify multiple documents
      #   bayes.classify_batch(["good documentation", "damn workin again"])
      #   =>
      def classify_batch(docs)
        docs.collect { |doc| classify(doc) }
      end

    end
  end
end