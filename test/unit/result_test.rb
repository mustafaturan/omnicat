require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestResult < Test::Unit::TestCase
  def setup
    @result = OmniCat::Result.new
    @score1 = OmniCat::Score.new(key: 'pos', value: 0.43)
    @score2 = OmniCat::Score.new(key: 'net', value: 0.76)
    @score3 = OmniCat::Score.new(key: 'neg', value: 0.11)
  end

  def test_add_score
    @result.add_score(@score1)
    assert_equal(@score1, @result.scores[@score1.key])
  end

  def test_top_score
    @result.add_score(@score1)
    @result.add_score(@score2)
    @result.add_score(@score3)
    assert_equal(@score2, @result.top_score)
  end

  def test_percentage
    @result.add_score(@score1)
    @result.add_score(@score2)
    @result.add_score(@score3)
    @result.calculate_percentages
    assert_equal(33, @score1.percentage)
    assert_equal(58, @score2.percentage)
    assert_equal(8, @score3.percentage)
  end
end