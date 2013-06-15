module OmniCat
  module Classifiers
    class Bayes < ::OmniCat::Classifiers::Base

      attr_accessor :categories, :category_count, :doc_count, :token_count
      attr_accessor :k_value # helper val for skipping some Bayes theorem errors

      def initialize(bayes_hash = {})
        self.categories = ::OmniCat::Hash.new
        if bayes_hash.has_key?(:categories)
          bayes_hash[:categories].each do |name, category|
            self.categories[name] = ::OmniCat::Classifiers::BayesInternals::Category.new(category)
          end
        end
        self.category_count = bayes_hash[:category_count].to_i
        self.doc_count = bayes_hash[:doc_count].to_i
        self.k_value = bayes_hash[:k_value] || 1.0
        self.token_count = bayes_hash[:token_count].to_i
      end

      # Allows adding new classification category
      #
      # ==== Parameters
      #
      # * +name+ - Name for category
      #
      # ==== Examples
      #
      #   # Create a classification category
      #   bayes = Bayes.new
      #   bayes.add_category("positive")
      def add_category(name)
        if category_exists?(name)
          raise StandardError,
                "Category with name '#{name}' is already exists!"
        else
          self.category_count +=1
          self.categories[name] = ::OmniCat::Classifiers::BayesInternals::Category.new
        end
      end

      # Train the desired category with a document
      #
      # ==== Parameters
      #
      # * +category+ - Name of the category from added categories list
      # * +doc+ - Document text
      #
      # ==== Examples
      #
      #   # Train the desired category
      #   bayes.train("positive", "clear documentation")
      #   bayes.train("positive", "good, very well")
      #   bayes.train("negative", "bad dog")
      #   bayes.train("neutral", "how is the management gui")
      def train(category, doc)
        if category_exists?(category)
          self.doc_count += 1
          categories[category].doc_count += 1
          doc.tokenize_with_counts.each do |token, count|
            self.token_count += count
            self.categories[category].tokens[token] = self.categories[category].tokens[token].to_i + count
            self.categories[category].token_count += count
          end
        else
          raise StandardError,
                "Category with name '#{category}' does not exist!"
        end
      end

      # Classify the given document
      #
      # ==== Parameters
      #
      # * +doc+ - The document for classification
      #
      # ==== Returns
      #
      # * +result+ - OmniCat::Result object
      #
      # ==== Examples
      #
      #   # Classify a document
      #   bayes.classify("good documentation")
      #   =>
      def classify(doc)
        if category_count < 2
          return raise StandardError,
                       "At least 2 categories needed for classification process!"
        end
        score = -1000000
        result = ::OmniCat::Result.new
        categories.each do |name, category|
          prior = category.doc_count / doc_count.to_f
          result.scores[name] = k_value
          doc.tokenize_with_counts.each do |token, count|
            result.scores[name] *= (
              (category.tokens[token].to_i + k_value) /
              (category.token_count + token_count)
            ) if category.tokens.has_key?(token)
          end
          result.scores[name] = (
            result.scores[name].to_f == 1.0 ? 0 : (prior * result.scores[name])
          )
          if result.scores[name] > score
            result.category[:name] = name;
            score = result.scores[name];
          end
          result.total_score += result.scores[name]
        end
        result.total_score = 1 if result.total_score == 0
        result.category[:percentage] = (
          result.scores[result.category[:name]] * 100.0 /
          result.total_score
        ).floor
        result
      end

      private
        # nodoc
        def category_exists?(category_name)
          categories.has_key?(category_name)
        end

    end
  end
end