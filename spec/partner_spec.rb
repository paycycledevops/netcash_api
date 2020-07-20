RSpec.describe NetcashApi::Partner do
  let(:account_sk) { ENV['ACCOUNT_SERVICE_KEY'] }
  let(:software_vendor_key) { ENV['SOFTWARE_VENDOR_KEY'] }
  let(:merchant_account) { ENV['MERCHANT_ACCOUNT'] }
  let(:example) {
    {
      'MethodParameters' => {
        'request' => {
          'SoftwareVendorKey' => software_vendor_key,
          'MerchantAccount' => merchant_account,
          'ServiceInfoList' => [{
            'ServiceInfo' => {
              'ServiceKey' => account_sk,
              'ServiceId' => 1
            }
          }]
        }
      }
    }
  }

  it do
    client = Savon.client(
      wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_Partner.svc?singleWsdl',
      #wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_PartnerMobile.svc?singleWsdl',
    )
#   client = NetcashApi::Partner
#   client = Savon.client(
#     wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_PartnerMobile.svc?singleWsdl',
#     soap_header: { "wsa:Action" => "http://tempuri.org/INIWS_Partner/ValidateServiceKey" }
#   )

    r = client.call(:validate_service_key,
      soap_action: "http://tempuri.org/INIWS_Partner/ValidateServiceKey",
      xml: xml_string)
#      message: { 'ServiceKey' => '1231231231', 'File' => ''})

    #response = VCR.use_cassette 'validate_service_key' do
      #client.call(:validate_service_key, xml: xml_string)
    #end
    binding.pry
  end

  it do
    client = Savon.client(
      wsdl: 'https://ws.netcash.co.za/NIWS/NIWS_PartnerMobile.svc',
      soap_header: { "wsa:Action" => "http://tempuri.org/INIWS_Partner/ValidateServiceKey" }
    )

    response = VCR.use_cassette 'validate_service_key' do
#     client = NetcashApi::Client.partner
#     client.globals.soap_header(
#       "wsa:To" => "https://ws.netcash.co.za/NIWS/NIWS_Partner.svc",
#       "wsa:Action" => "http://tempuri.org/INIWS_Partner/ValidateServiceKey",
#     )
      client = NetcashApi::Client.partner

      client.call(:validate_service_key,
        message: {
          validate_service_key_request: {
            software_vendor_key: software_vendor_key,
            merchant_account: merchant_account,
            service_info_list: {
              service_info: {
                service_key: account_sk,
                service_id: 1
              }
            }
          }
        }
      )
    end
    binding.pry
  end

  it do
    client = NetcashApi::Client.partner
#   client.globals.soap_header(
#     "wsa:To" => "https://ws.netcash.co.za/NIWS/NIWS_Partner.svc",
#     "wsa:Action" => "http://tempuri.org/INIWS_Partner/ValidateServiceKey",
#   )

    response = VCR.use_cassette 'validate_service_key_xml' do
      client.call(:validate_service_key,xml: xml_string)
    end

    binding.pry
  end
end

def xml_string_1
'
<MethodParameters>
  <request>
   <SoftwareVendorKey>24ade73c-98cf-47b3-99be-cc7b867b3080</SoftwareVendorKey>
    <MerchantAccount>123456767</MerchantAccount>
      <ServiceInfoArray>
        <ServiceInfoArray0>
         <ServiceId>1</ServiceId>
         <ServiceKey>1234566778899999999999999</ServiceKey>
        </ServiceInfoArray0>
       </ServiceInfoArray>
  </request>
 </MethodParameters>'
end

def xml_string
  '<tem:ValidateServiceKey>
         <tem:request>
            <nc:MerchantAccount>510000000000</nc:MerchantAccount>
            <nc:ServiceInfoList>
               <nc:ServiceInfo>
                  <nc:ServiceId>1</nc:ServiceId>
                  <nc:ServiceKey>00000000-0000-0000-0000-000000000000</nc:ServiceKey>
               </nc:ServiceInfo>
            </nc:ServiceInfoList>
           <nc:SoftwareVendorKey>00000000-0000-0000-0000-000000000000</nc:SoftwareVendorKey>
         </tem:request>
      </tem:ValidateServiceKey>'
end
