require File.dirname(__FILE__) + '/omnicat/version'
require File.dirname(__FILE__) + '/omnicat/configuration'
require File.dirname(__FILE__) + '/omnicat/array'
require File.dirname(__FILE__) + '/omnicat/base'
require File.dirname(__FILE__) + '/omnicat/doc'
require File.dirname(__FILE__) + '/omnicat/result'
require File.dirname(__FILE__) + '/omnicat/classifier'

module OmniCat
  def self.config
    OmniCat::Configuration.instance
  end

  def self.configure
    yield config
  end

  def self.logger
    config.logger
  end
end