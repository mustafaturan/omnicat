require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestArray < Test::Unit::TestCase
  def test_hashify_with_counts
    assert_equal(
      {"omnicat" => 2, "written" => 1, "at" => 1, "2011" => 1},
      ["omnicat", "written", "at", "2011", "omnicat"].hashify_with_counts
    )
  end
end
