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
        # NIWS_Partner is a WCF service (SOAP 1.2, WSHttpBinding with WS-Addressing
        # required). WCF validates the wsa:To header against the endpoint address, so it
        # must be sent explicitly. Without it the To arrives empty and WCF rejects the
        # request with an "AddressFilter mismatch at the EndpointDispatcher" fault before
        # the service keys are ever checked.
        @_partner ||= Savon.client(
          wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Partner.svc?wsdl',
          soap_header: {
            "wsa:Action" => "http://tempuri.org/INIWS_Partner/ValidateServiceKey",
            "wsa:To"     => "https://ws.netcash.co.za/NIWS/NIWS_Partner.svc"
          },
          soap_version: 2,
          pretty_print_xml: true
        )
      end
    end
  end
end
