require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestString < Test::Unit::TestCase
  def test_omnicat_tokenize
    assert_equal(
      ["mustafa", "turan", "omni-cat-v0", "1986"],
      "mustafa turan omni-cat-v0 1986 1 a s d".omnicat_tokenize
    )
  end

  def test_tokenize_with_counts
    assert_equal(
      {"omnicat" => 2, "written" => 1, "at" => 1, "2011" => 1},
      "omnicat written at 2011, omnicat".tokenize_with_counts
    )
  end
end