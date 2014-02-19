# encoding: UTF-8
require 'digest'
require File.dirname(__FILE__) + '/base'

module OmniCat
  class Doc < ::OmniCat::Base
    attr_reader :content, :content_md5, :count, :tokens

    def initialize(doc_hash = {})
      @auto_classified = doc_hash[:auto_classified] || false
      @content = doc_hash[:content]
      @content_md5 = doc_hash[:content_md5] || Digest::MD5.hexdigest("#{@content}")
      @count = (doc_hash[:count] || 1).to_i
      @tokens = tokenize_with_counts unless @tokens.is_a?(Hash)
    end

    def increment_count
      @count += 1
    end

    def decrement_count
      @count -= 1 if @count > 0
    end

    private
      # nodoc
      def minus_tokens
        body = @content
        OmniCat.config.token_patterns[:minus].each { |p| body.gsub!(p, ' ') }
        body
      end

      # nodoc
      def plus_tokens(body)
        body_tokens = []
        OmniCat.config.token_patterns[:plus].each { |p| body_tokens += body.scan(p) }
        body_tokens
      end

      # nodoc
      def exclude_tokens
        OmniCat.config.exclude_tokens
      end

      # nodoc
      def tokenize_with_counts
        tokenize.hashify_with_counts
      end

      # nodoc
      def tokenize
        plus_tokens(minus_tokens) - exclude_tokens
      end
  end
end