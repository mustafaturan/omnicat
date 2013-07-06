# encoding: UTF-8
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestDoc < Test::Unit::TestCase
  def setup
    OmniCat.configure do |config|
      config.exclude_tokens = ["was", "at", "by"]
      config.token_patterns = {
        minus: [/[\s\t\n\r]+/, /(@[\w\d]+)/],
        plus: [/[\p{L}\-0-9]{2,}/, /[\!\?]/, /[\:\)\(\;\-\|]{2,3}/]
      }
    end
    @doc = OmniCat::Doc.new(
      content: "omnicat v-01 was written at 2011, omnicat by @mustafaturan"
    )
  end

  def test_omnicat_tokenize
    assert_equal(
      {"omnicat" => 2, "v-01" => 1, "written" => 1, "2011" => 1},
      @doc.tokens
    )
  end

  def test_increment_count
    @doc.increment_count
    assert_equal(2, @doc.count)
  end

  def test_decrement_count
    @doc.decrement_count
    assert_equal(0, @doc.count)
  end

  def test_decrement_count_if_zero
    @doc.decrement_count
    @doc.decrement_count
    assert_equal(0, @doc.count)
  end
end