require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestBayes < Test::Unit::TestCase
  def setup
    @bayes = OmniCat::Classifiers::Bayes.new
  end

  def test_add_category
    @bayes.add_category "neutral"
    assert_not_nil(@bayes.categories["neutral"])
    assert_equal(
      ["neutral"],
      @bayes.categories.keys
    )
    assert_equal(
      0,
      @bayes.categories["neutral"].doc_count
    )
    assert_equal(
      {},
      @bayes.categories["neutral"].tokens
    )
    assert_equal(
      0,
      @bayes.categories["neutral"].token_count
    )
  end

  def test_add_category_that_already_exists
    @bayes.add_category "neutral"
    assert_raise(StandardError) { @bayes.add_category "neutral" }
  end

  def test_train_valid_category
    @bayes.add_category "neutral"
    @bayes.train "neutral", "how are you?"
    assert_equal(
      1,
      @bayes.categories["neutral"].doc_count
    )
    assert_equal(
      {"how" => 1, "are" => 1, "you" => 1},
      @bayes.categories["neutral"].tokens
    )
    assert_equal(
      3,
      @bayes.categories["neutral"].token_count
    )
  end

  def test_train_missing_category
    assert_raise(StandardError) { @bayes.train "neutral", "how are you?" }
  end

  def test_classify
    @bayes.add_category "positive"
    @bayes.add_category "negative"
    @bayes.train("positive", "good job")
    @bayes.train("negative", "bad work")
    assert_equal(
      "positive",
      @bayes.classify("very good position for this sentence").category[:name]
    )
    assert_equal(
      "negative",
      @bayes.classify("bad words").category[:name]
    )
  end

  def test_initialize_with_hash
    bayes1 = ::OmniCat::Classifiers::Bayes.new
    bayes1.add_category "positive"
    bayes1.add_category "negative"
    bayes1.train("positive", "good job")
    bayes1.train("negative", "bad work")
    h1 = bayes1.to_hash

    bayes2 = ::OmniCat::Classifiers::Bayes.new(h1)
    assert_equal(h1, bayes2.to_hash)
  end

  def test_classify_with_insufficient_categories
    assert_raise(StandardError) { @bayes.classify "blank" }
  end
end
