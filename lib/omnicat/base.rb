require 'hashable'

module OmniCat
  class Base
    include Hashable
    def to_hash; self.to_dh; end
  end
end