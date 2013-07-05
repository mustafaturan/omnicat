require 'singleton'
require 'logger'

module OmniCat
  class Configuration
    include Singleton
    attr_accessor :logger
    attr_accessor :exclude_tokens, :logger, :token_patterns

    def self.default_logger
      logger = Logger.new(STDOUT)
      logger.progname = 'omnicat'
      logger
    end

    @@defaults = {
      exclude_tokens: ['a','about','across','after','all','almost','also','am','among','an','and','are','as','at','be','because','been','by','did','do','does','else','ever','every','for','from','get','got','had','has','have','he','her','hers','him','his','how','however','i','if','in','into','is','it','its','just','least','let','may','me','might','most','must','my','of','often','on','only','or','other','our','own','rather','said','say','says','she','should','since','so','some','than','that','the','their','them','then','there','these','they','this','tis','to','too','twas','us','wants','was','we','were','what','when','where','which','while','who','whom','will','with','would','yet','you','your'],
      logger: default_logger,
      token_patterns: {
        minus: [/[\s\t\n\r]+/, /(@[\w\d]+)/],
        plus: [/[\p{L}\-0-9]{2,}/, /[\!\?]/, /[\:\)\(\;\-\|]{2,3}/]
      }
    }

    def self.defaults
      @@defaults
    end

    def initialize
      @@defaults.each_pair{|k,v| self.send("#{k}=",v)}
    end
  end
end