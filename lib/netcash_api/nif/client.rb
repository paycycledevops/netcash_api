require 'savon'

module NetcashApi
  module Nif
    class Client < NetcashApi::Client
      def client
        @_client ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_NIF.svc?wsdl')
      end
    end
  end
end
