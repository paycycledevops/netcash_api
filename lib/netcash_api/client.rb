module NetcashApi
  class Client
    class << self
      def validation
        @_validation ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Validation.svc?wsdl')
      end

      def nif
        @_nif ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_NIF.svc?wsdl')
      end

      def partner
        @_partner ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Partner.svc?wsdl')
      end
    end
  end
end
