module OmniCat
  module Classifiers
    #
    # Author::    Mustafa Turan (mailto:mustafaturan.net@gmail.com)
    # Copyright:: Copyright (c) 2013 Mustafa Turan
    # License::   MIT
    #
    # The class supplies abstract methods for possible text classifiers
    class Base < ::OmniCat::Base
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

    end
  end
end