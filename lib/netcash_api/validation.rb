module NetcashApi
  class Validation
    class << self
      def method_missing(end_point, params, &block)
        response = NetcashApi::Client.validation.call(end_point, {
          message: XmlKeyAdapter.convert_keys(params)
        })

        if block_given?
          yield response
        else
          return response
        end
      end
    end
  end
end
