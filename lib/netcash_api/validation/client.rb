require 'savon'

module NetcashApi
  module Validation
    class Client < NetcashApi::Client
      def client
        @_client ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Validation.svc?wsdl')
      end
    end
  end
end
