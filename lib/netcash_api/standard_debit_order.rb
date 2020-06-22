module NetcashApi
  class StandardDebitOrder
    class << self
      def method_missing(end_point, params, &block)
        response = NetcashApi::Client.nif.call(end_point, {
          message: XmlKeyAdapter.convert_keys(params)
        })

        yield(response) if block_given?
      end
    end
  end
end
