# OmniCat

A generalized framework for text classifications. For now, it only supports Naive Bayes algorithm for text classification.

## Installation

Add this line to your application's Gemfile:

    gem 'omnicat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omnicat

## Usage

See rdoc for detailed usage.

### Bayes classifier
Create a Bayes classifier object.

    bayes = OmniCat::Classifiers::Bayes.new

### Create categories
Create a classification category.

    bayes.add_category('positive')
    bayes.add_category('negative')

### Train
Train category with a document.

    bayes.train('positive', 'great if you are in a slap happy mood .')
    bayes.train('negative', 'bad tracking issue')

### Train batch
Train category with multiple documents.

    bayes.train_batch('positive', [
      'a feel-good picture in the best sense of the term...',
      'it is a feel-good movie about which you can actually feel good.',
      'love and money both of them are good choises'
    ])
    bayes.train_batch('negative', [
      'simplistic , silly and tedious .',
      'interesting , but not compelling . ',
      'seems clever but not especially compelling'
    ])

### Classify
Classify a document.

    result = bayes.classify('I feel so good and happy')
    => #<OmniCat::Result:0x007fe59b97b548 @category={:name=>"negative", :percentage=>99}, @scores={"positive"=>1.749909854122994e-07, "negative"=>0.014084507042253521}, @total_score=0.014084682033238934>
    result.to_hash
    => {:category=>{:name=>"negative", :percentage=>99}, :scores=>{"positive"=>1.749909854122994e-07, "negative"=>0.014084507042253521}, :total_score=>0.014084682033238934}

### Classify batch
Classify multiple documents at a time.

    results = bayes.classify_batch(
      [
        'the movie is silly so not compelling enough',
        'a good piece of work'
      ]
    )
    => [#<OmniCat::Result:0x007fe59b949d90 @category={:name=>"negative", :percentage=>75}, @scores={"positive"=>7.962089836259623e-06, "negative"=>2.5145916163515512e-05}, @total_score=3.3108005999775135e-05>, #<OmniCat::Result:0x007fe59c9d7d10 @category={:name=>"positive", :percentage=>100}, @scores={"positive"=>0.0005434126313247192, "negative"=>0}, @total_score=0.0005434126313247192>]

### Convert to hash
Convert full Bayes object to hash.

    # For storing, restoring modal data
    bayes_hash = bayes.to_hash

### Load from hash
Load full Bayes object from hash.

    another_bayes_obj = OmniCat::Classifiers::Bayes.new(bayes_hash)
    another_bayes_obj.classify('best senses')

## Todo
* Add more text classification modules such as Support Vector Machine (SVM).
* Add text cleaning/manipulating extensions such as stopwords cleaner, stemmer, and pos-tagger, etc...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright
Copyright © 2013 Mustafa Turan. See LICENSE for details.

