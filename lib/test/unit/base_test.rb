require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestBase < Test::Unit::TestCase
  def setup
    @base = OmniCat::Classifiers::Base.new
  end

  def test_add_category
    assert_raise(NotImplementedError) { @base.add_category("positive") }
  end

  def test_add_categories
    assert_raise(NotImplementedError) { @base.add_categories(
      ["neutral", "positive", "negative"]) }
  end

  def test_train
    assert_raise(NotImplementedError) { @base.train("positive", "good") }
  end

  def test_train_batch
    assert_raise(NotImplementedError) {
      @base.train_batch("positive", ["good job ever", "valid syntax",
      "best moments of my life"])
    }
  end

  def test_untrain
    assert_raise(NotImplementedError) { @base.untrain("positive", "good") }
  end

  def test_untrain_batch
    assert_raise(NotImplementedError) { @base.untrain_batch(
      "positive", ["good work", "well done"]) }
  end

  def test_classify
    assert_raise(NotImplementedError) { @base.classify("good job") }
  end

  def test_classify_batch
    assert_raise(NotImplementedError) {
      @base.classify_batch(["good job", "you did well"])
    }
  end
end
