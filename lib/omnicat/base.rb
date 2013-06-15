module OmniCat
  class Base
    # Returns Base object as Hash
    #
    # @return Base object instance variables in a Hash
    def to_hash
      hash = {}
      self.instance_variables.each do |key|
        if val = instance_variable_get(key)
          hash[key[1..-1].to_sym] = val.class.to_s.include?('OmniCat') ? val.to_hash : val
        end
      end
      hash
    end
  end
end