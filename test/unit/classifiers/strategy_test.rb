require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'test_helper'))

class TestStrategy < Test::Unit::TestCase
  def setup
    @strategy = OmniCat::Classifiers::Strategy.new
  end

  def test_add_category
    assert_raise(NotImplementedError) { @strategy.add_category("positive") }
  end

  def test_add_categories
    assert_raise(NotImplementedError) { @strategy.add_categories(
      ["neutral", "positive", "negative"]) }
  end

  def test_train
    assert_raise(NotImplementedError) { @strategy.train("positive", "good") }
  end

  def test_train_batch
    assert_raise(NotImplementedError) {
      @strategy.train_batch("positive", ["good job ever", "valid syntax",
      "best moments of my life"])
    }
  end

  def test_untrain
    assert_raise(NotImplementedError) { @strategy.untrain("positive", "good") }
  end

  def test_untrain_batch
    assert_raise(NotImplementedError) { @strategy.untrain_batch(
      "positive", ["good work", "well done"]) }
  end

  def test_classify
    assert_raise(NotImplementedError) { @strategy.classify("good job") }
  end

  def test_classify_batch
    assert_raise(NotImplementedError) {
      @strategy.classify_batch(["good job", "you did well"])
    }
  end
end
