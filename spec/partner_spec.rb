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
          'ServiceInfoArray' => {
            'ServiceInfoArray0' => {
              'ServiceKey' => account_sk,
              'ServiceId' => 1
            }
          }
        }
      }
    }
  }

  it do
    VCR.use_cassette 'validate_service_key' do
      response = NetcashApi::Client.partner.call(:validate_service_key,
        message: example)
      binding.pry
    end
  end

  it do
    VCR.use_cassette 'validate_service_key' do
      #response = NetcashApi::Partner.validate_service_key(
      response = NetcashApi::Client.partner.call(:validate_service_key,
        message: {
          validate_service_key_request: {
            software_vendor_key: software_vendor_key,
            merchant_account: merchant_account,
            service_info_list_array: {
              service_info_array_0: {
                service_key: account_sk,
                service_id: 1
              }
            }
          }
        }
      )
      binding.pry
    end
  end

  it do
    VCR.use_cassette 'validate_service_key_xml' do
      response = NetcashApi::Client.partner.call(:validate_service_key, xml: xml_string)
      binding.pry
    end
  end
end

def xml_string
'</ValidateServiceKey>
<MethodParameters>
  <request>
   <SoftwareVendorKey>24ade73c-98cf-47b3-99be-cc7b867b3080</SoftwareVendorKey>
    <MerchantAccount>52624757488</MerchantAccount>
      <ServiceInfoArray>
        <ServiceInfoArray0>
         <ServiceId>1</ServiceId>
         <ServiceKey>4724c261-dad5-4a64-852c-9b88a67b3c50</ServiceKey>
        </ServiceInfoArray0>
       </ServiceInfoArray>
  </request>
 </MethodParameters>
</ValidateServiceKey>'
end
