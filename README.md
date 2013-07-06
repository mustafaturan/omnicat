# OmniCat

[![Build Status](https://travis-ci.org/mustafaturan/omnicat.png)](https://travis-ci.org/mustafaturan/omnicat) [![Code Climate](https://codeclimate.com/github/mustafaturan/omnicat.png)](https://codeclimate.com/github/mustafaturan/omnicat)

A generalized framework for text classifications.

## Installation

Add this line to your application's Gemfile:

    gem 'omnicat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omnicat

## Usage

Stand-alone version of omnicat is just a strategy holder for developers. Its aim is providing omnification of methods for text classification gems with loseless conversion of a strategy to another one. End-users should see 'classifier strategies' section and 'changing classifier strategy' sub section.

### Changing classifier strategy

OmniCat allows you to change strategy on runtime.

    # Declare classifier with Naive Bayes classifier
    classifier = OmniCat::Classifier.new(OmniCat::Classifiers::Bayes.new())
    ...
    # do some operations like adding category, training, etc...
    ...
    # make some classification using Bayes
    classifier.classify('I am happy :)')
    ...
    # change strategy to Support Vector Machine (SVM) on runtime
    classifier = OmniCat::Classifier.new(OmniCat::Classifiers::SVM.new())
    # now you do not need to re-train, add category and so on..
    # just classify with new strategy
    classifier.classify('I am happy :)')

## Classifier strategies
Here is the classifier list avaliable for OmniCat.

### Naive Bayes classifier
* gem 'omnicat-bayes'
* Details: http://github.com/mustafaturan/omnicat-bayes

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright
Copyright © 2013 Mustafa Turan. See LICENSE for details.

