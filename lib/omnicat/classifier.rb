require File.dirname(__FILE__) + '/classifiers/strategy'
require File.dirname(__FILE__) + '/classifiers/strategy_internals/category'
require 'forwardable'

module OmniCat
  class Classifier
    extend Forwardable

    # classification strategy
    attr_accessor :strategy

    # delegate category methods
    def_delegators :@strategy, :add_category, :add_categories, :category_size_limit

    # delegate training methods
    def_delegators :@strategy, :train, :train_batch, :untrain, :untrain_batch

    # delegate classification methods
    def_delegators :@strategy, :classify, :classify_batch

    # delegate base methods
    def_delegator :@strategy, :to_hash

    # nodoc
    def initialize(classifier)
      @strategy = classifier
    end

    # Changes classifier strategy and train new strategy if needed
    #
    def strategy=(classifier)
      is_interchangeable?(classifier)
      if @strategy && classifier.category_count == 0
        previous_strategy = @strategy
        @strategy = classifier
        convert_categories_with_docs(previous_strategy)
      else
        @strategy = classifier
      end
    end

    private
      # nodoc
      def convert_categories_with_docs(previous_strategy)
        if previous_strategy.categories.is_a?(Hash)
          convert_categories_hash(previous_strategy.categories)
        else
          convert_categories_array(previous_strategy.categories)
        end
      end

      # nodoc
      def convert_categories_array(categories)
        categories.each do |category|
          convert_category(category)
        end
      end

      # nodoc
      def convert_categories_hash(categories)
        categories.each do |_, category|
          convert_category(category)
        end
      end

      # nodoc
      def convert_category(category)
        @strategy.add_category(category.name)
        if category.docs.is_a?(Hash)
          convert_docs_hash(category.name, category.docs)
        else
          convert_docs_array(category.name, category.docs)
        end
      end

      # nodoc
      def convert_docs_array(category_name, docs)
        docs.each do |doc|
          convert_doc(category_name, doc)
        end
      end

      # nodoc
      def convert_docs_hash(category_name, docs)
        docs.each do |_, doc|
          convert_doc(category_name, doc)
        end
      end

      # nodoc
      def convert_doc(category_name, doc)
        doc.count.times do
          @strategy.train(category_name, doc.content)
        end
      end

      # nodoc
      def is_interchangeable?(classifier)
        unless classifier.category_size_limit == 0
          if @strategy.category_count > classifier.category_size_limit
            raise StandardError,
              'New classifier category size limit is less than the current classifier\'s category count.'
          end
        end
      end
  end
end