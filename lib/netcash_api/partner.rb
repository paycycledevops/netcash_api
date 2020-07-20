module NetcashApi
  class Partner
    class << self
      def method_missing(end_point, params, &block)
        NetcashApi::Client.send(self.to_s.demodulize.underscore.downcase).call(end_point, xml: params)
      end
    end
  end
end
