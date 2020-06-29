RSpec.describe NetcashApi::Validation do
  let(:validation_service_key) { '1234' }

  it do
    VCR.use_cassette 'bank_account_validation' do
      response = NetcashApi::Validation.validate_bank_account(
        service_key: validation_service_key,
        account_number: 123456789,
        branch_code: 632005,
        account_type: 1
      )
      expect(response.body.dig(:validate_bank_account_response, :validate_bank_account_result)).to eq '0'
    end
  end
end
