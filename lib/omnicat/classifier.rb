require File.dirname(__FILE__) + '/classifiers/strategy'
require File.dirname(__FILE__) + '/classifiers/strategy_internals/category'
require 'forwardable'

module OmniCat
  class Classifier
    extend Forwardable

    # classification strategy
    attr_accessor :strategy

    # delegate category methods
    def_delegators :@strategy, :add_category, :add_categories

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

    def strategy=(classifier)
      is_interchangeable?(classifier)
      if @strategy && classifier.doc_count == 0
        previous_strategy = @strategy
        @strategy = classifier
        # pass previous strategy contents into the new one
        previous_strategy.categories.each do |category_name, category|
          @strategy.add_category(category_name)
          category.docs.each do |_, doc|
            doc.count.times do
              @strategy.train(category_name, doc.content)
            end
          end
        end
      else
        @strategy = classifier
      end
    end

    private
      def is_interchangeable?(classifier)
        if classifier.category_size_limit
          if @strategy.category_count > classifier.category_size_limit
            raise StandardError, 
              'New classifier category size limit is less than the current classifier\'s category count.'
          end
        end
      end
  end
end