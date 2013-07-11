require 'omnicat'

module OmniCat
  module Classifiers
    #
    # Author::    Mustafa Turan (mailto:mustafaturan.net@gmail.com)
    # Copyright:: Copyright (c) 2013 Mustafa Turan
    # License::   MIT
    #
    # The class supplies abstract methods for possible text classifiers
    class Strategy < ::OmniCat::Base
      attr_accessor :categories # ::OmniCat::Hash - Hash of categories
      attr_accessor :category_count # Integer - Total category count
      attr_accessor :category_size_limit # Integer - Max allowed category
      attr_accessor :doc_count # Integer - Total token count
      attr_accessor :token_count # Integer - Total token count
      attr_accessor :uniq_token_count # Integer - Total uniq token count

      def initialize(strategy_hash = {})
        @categories = {}
        @category_count = strategy_hash[:category_count].to_i
        @category_size_limit = strategy_hash[:category_size_limit].to_i
        @doc_count = strategy_hash[:doc_count].to_i
        @token_count = strategy_hash[:token_count].to_i
        @uniq_token_count = strategy_hash[:uniq_token_count].to_i
      end

      # Abstract method for adding new classification category
      #
      # ==== Parameters
      #
      # * +name+ - Name for category
      #
      def add_category(name)
        not_implemented_error(__callee__)
      end

      # Allows adding multiple classification categories
      #
      # ==== Parameters
      #
      # * +names+ - Array of categories
      #
      def add_categories(names)
        names.each { |name| add_category(name) }
      end

      # Abstract method for training the desired category with a document
      #
      # ==== Parameters
      #
      # * +category+ - Name of the category from added categories list
      # * +doc+ - Document text
      #
      def train(category_name, doc)
        not_implemented_error(__callee__)
      end

      # Train the desired category with multiple documents
      #
      # ==== Parameters
      #
      # * +category+ - Name of the category from added categories list
      # * +docs+ - Array of documents
      #
      def train_batch(category, docs)
        docs.each { |doc| train(category, doc) }
      end

      # Abstract method for untraining the desired category with a document
      #
      # ==== Parameters
      #
      # * +category+ - Name of the category from added categories list
      # * +doc+ - Document text
      #
      def untrain(category_name, doc)
        not_implemented_error(__callee__)
      end

      # Untrain the desired category with multiple documents
      #
      # ==== Parameters
      #
      # * +category+ - Name of the category from added categories list
      # * +docs+ - Array of documents
      #
      def untrain_batch(category, docs)
        docs.each { |doc| untrain(category, doc) }
      end

      # Abstract method for classifying the given document
      #
      # ==== Parameters
      #
      # * +doc+ - The document for classification
      #
      # ==== Returns
      #
      # * +result+ - OmniCat::Result object
      #
      def classify(doc)
        not_implemented_error(__callee__)
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
      def classify_batch(docs)
        docs.collect { |doc| classify(doc) }
      end

      private
        # nodoc
        def not_implemented_error(method_name)
          raise NotImplementedError.new("#{self.class.name}##{method_name} method is not implemented!")
        end

      protected
        # nodoc
        def category_exists?(category_name)
          categories.has_key?(category_name)
        end

        # nodoc
        def increment_category_count
          @category_count += 1
        end

        # nodoc
        def decrement_category_count
          @category_count -= 1
        end

        # nodoc
        def increment_doc_counts(category_name)
          @doc_count += 1
          @categories[category_name].doc_count += 1
        end

        # nodoc
        def decrement_doc_counts(category_name)
          @doc_count -= 1
          @categories[category_name].doc_count -= 1
        end

        # nodoc
        def classifiable?
          if category_count < 2
            raise StandardError,
                  'At least 2 categories needed for classification process!'
            false
          elsif doc_avability? == false
            raise StandardError,
                  'Each category must trained with at least one document!'
            false
          else
            true
          end
        end

        # nodoc
        def doc_avability?
          @categories.each do |_, category|
            return false if category.doc_count == 0
          end
          true
        end
    end
  end
end