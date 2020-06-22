module NetcashApi
  class XmlKeyAdapter
    class << self
      def convert_keys(hash)
        hash.transform_keys { |k| "tns:#{k.to_s.camelize}" }
      end
    end
  end
end
