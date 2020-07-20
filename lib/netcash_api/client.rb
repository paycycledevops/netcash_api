module NetcashApi
  class Client
    class << self
      def validation
        @_validation ||= Savon.client(
          wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Validation.svc?wsdl',
          pretty_print_xml: true
        )
      end

      def standard_debit_order
        @_nif ||= Savon.client(wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_NIF.svc?wsdl',
          pretty_print_xml: true
        )
      end

      def partner
        @_partner ||= Savon.client(
          wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Partner.svc?wsdl',
          soap_header: { "wsa:Action" => "http://tempuri.org/INIWS_Partner/ValidateServiceKey" },
          soap_version: 2,
          pretty_print_xml: true
        )
      end
    end
  end
end
