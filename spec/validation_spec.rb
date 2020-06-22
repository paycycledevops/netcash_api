RSpec.describe NetcashApi::Validation do
  let(:validation_service_key) { '4724c261-dad5-4a64-852c-9b88a67b3c50' }

  it do
    response_key = nil

    NetcashApi::Validation.validate_bank_account(
      service_key: validation_service_key,
      account_number: 123456789,
      branch_code: 632005,
      account_type: 1
    ) do |response|
      response_key = response.body[:validate_bank_account_response][:validate_bank_account_result]
    end

    expect(response_key).to eq '0'
  end
end
