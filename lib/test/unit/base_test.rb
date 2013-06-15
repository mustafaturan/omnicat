require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestBase < Test::Unit::TestCase
  def setup
    @bayes = OmniCat::Classifiers::Bayes.new
  end

  def test_add_categories
    @bayes.add_categories ["neutral", "positive", "negative"]
    assert_not_nil(@bayes.categories["neutral"])
    assert_equal(
      ["neutral", "positive", "negative"],
      @bayes.categories.keys
    )
  end

  def test_train_batch
    @bayes.add_category "positive"
    @bayes.train_batch "positive", ["good job ever", "valid syntax",
      "best moments of my life"]
    assert_equal(
      3,
      @bayes.categories["positive"].doc_count
    )
  end

  def test_classify_batch
    @bayes.add_category "positive"
    @bayes.add_category "negative"
    @bayes.train_batch "positive", ["good job ever", "valid syntax",
      "best moments of my life"]
    @bayes.train_batch("negative", ["bad work", "awfull day", "never liked it"])
    results = @bayes.classify_batch(
      ["good sytanx research", "bad words"]
    )

    assert_equal(2, results.count)

    assert_equal(
      "positive",
      results[0].category[:name]
    )
    assert_equal(
      "negative",
      results[1].category[:name]
    )

  end
end
