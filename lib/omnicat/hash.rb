module OmniCat
  class Hash < ::Hash
    def to_hash
      hash = {}
      self.keys.each do |key|
        if val = self[key]
          hash[key] = val.class.to_s.include?('OmniCat') ? val.to_hash : val
        end
      end
      hash
    end
  end
end