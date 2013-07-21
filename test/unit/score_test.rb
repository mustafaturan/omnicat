require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestScore < Test::Unit::TestCase
  def setup
    @score = OmniCat::Score.new(key: 'pos', value: 0.43)
  end

  def test_percentage
    assert_equal(0, @score.percentage)
  end
end