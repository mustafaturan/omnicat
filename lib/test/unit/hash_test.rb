require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class TestHash < Test::Unit::TestCase
  def test_to_hash
    categories_hash = { "pos" => { doc_count: 0, tokens: {}, token_count: 0 } }
    categories = OmniCat::Hash.new
    categories["pos"] = OmniCat::Classifiers::BayesInternals::Category.new(categories_hash["pos"])
    assert_equal(categories_hash, categories.to_hash)
  end
end
