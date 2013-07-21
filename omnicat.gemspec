# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omnicat/version'

Gem::Specification.new do |spec|
  spec.name          = 'omnicat'
  spec.version       = OmniCat::VERSION
  spec.authors       = ['Mustafa Turan']
  spec.email         = ['mustafaturan.net@gmail.com']
  spec.description   = %q{A generalized framework for text classifications.}
  spec.summary       = spec.description
  spec.homepage      = 'https://github.com/mustafaturan/omnicat'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'hashable', '~> 0.1.2'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
