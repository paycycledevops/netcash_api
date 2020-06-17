RSpec.describe NetcashApi::Client do
  describe '.connect' do
    let(:nif_sk) { 'd930eccd-3a6c-40b5-a611-831a72d012c4' }
    let(:accounts_sk) { '4724c261-dad5-4a64-852c-9b88a67b3c50' }

    subject { NetcashApi::Client }

    it do
      file = File.open('spec/test_file.txt')
      #r = subject.nif_client.call(:batch_file_upload, message: { service_key: service_key, file: file.read })
      #r = subject.validation_client.call(:validate_bank_account,
      r = subject.validation_client.call(:validate_bank_account,
        message: {
          'ServiceKey' => accounts_sk,
          'AccountNumber' => '1341234123',
          'BranchCode' => '198765',
          'AccountType' => 'Current'
      })

      binding.pry
    end
  end
end
