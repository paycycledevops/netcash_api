require 'savon'

module NetcashApi
    class Client
      class << self
        def method_missing(m, args={}, &block)
          result = client.call(m, args)
          yield(result) if block_given?
        end

        def validation_client
          @_client ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Validation.svc?wsdl')
        end

        def nif_client
          @_client ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_NIF.svc?wsdl')
        end

        def partner_client
          @_client ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Partner.svc?wsdl')
        end
      end
    end
end
