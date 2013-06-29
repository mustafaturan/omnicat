module OmniCat
  module Classifiers
    class Bayes < ::OmniCat::Classifiers::Base

      attr_accessor :categories # ::OmniCat::Hash - Hash of categories
      attr_accessor :category_count # Integer - Total category count
      attr_accessor :doc_count # Integer - Total token count
      attr_accessor :token_count # Integer - Total token count
      attr_accessor :uniq_token_count # Integer - Total uniq token count
      attr_accessor :k_value # Integer - Helper value for skipping some Bayes algorithm errors

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
        self.uniq_token_count = bayes_hash[:uniq_token_count].to_i
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
      def train(category_name, doc)
        if category_exists?(category_name)
          increment_doc_counts(category_name)
          update_priors
          doc.tokenize_with_counts.each do |token, count|
            increment_token_counts(category_name, token, count)
            self.categories[category_name].tokens[token] = self.categories[category_name].tokens[token].to_i + count
          end
        else
          raise StandardError,
                "Category with name '#{category_name}' does not exist!"
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
        return unless classifiable?
        score = -1000000
        result = ::OmniCat::Result.new
        self.categories.each do |category_name, category|
          result.scores[category_name] = doc_probability(category, doc)
          if result.scores[category_name] > score
            result.category[:name] = category_name
            score = result.scores[category_name]
          end
          result.total_score += result.scores[category_name]
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

        # nodoc
        def increment_doc_counts(category_name)
          self.doc_count += 1
          self.categories[category_name].doc_count += 1
        end

        # nodoc
        def update_priors
          self.categories.each do |_, category|
            category.prior = category.doc_count / doc_count.to_f
          end
        end

        # nodoc
        def increment_token_counts(category_name, token, count)
          increment_uniq_token_count(token)
          self.token_count += count
          self.categories[category_name].token_count += count
        end

        # nodoc
        def increment_uniq_token_count(token)
          uniq_token_addition = 0
          categories.each do |_, category|
             if category.tokens.has_key?(token)
               uniq_token_addition = 1
               break
             end
          end
          self.uniq_token_count += 1 if uniq_token_addition == 0
        end

        # nodoc
        def doc_probability(category, doc)
          score = k_value
          doc.tokenize_with_counts.each do |token, count|
            score *= token_probability(category, token, count)
          end
          category.prior * score
        end

        # nodoc
        def token_probability(category, token, count)
          if category.tokens[token].to_i == 0
            k_value / token_count
          else
            count * (
              (category.tokens[token].to_i + k_value) /
              (category.token_count + uniq_token_count)
            )
          end
        end

        # nodoc
        def classifiable?
          if category_count < 2
            raise StandardError,
                  "At least 2 categories needed for classification process!"
            false
          elsif doc_avability? == false
            raise StandardError,
                  "Each category must trained with at least one document!"
            false
          else
            true
          end
        end

        # nodoc
        def doc_avability?
          self.categories.each do |_, category|
            return false if category.doc_count == 0
          end
          true
        end

    end
  end
end