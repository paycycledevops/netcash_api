RSpec.describe NetcashApi::Nif::BatchFileUpload do
  let(:nif_sk) { 'd930eccd-3a6c-40b5-a611-831a72d012c4' }
  let(:accounts_sk) { '4724c261-dad5-4a64-852c-9b88a67b3c50' }

  let(:transactions) { attributes_for_list :transaction, 5 }

  subject { NetcashApi::Nif::BatchFileUpload }

  it do
    f = subject.new(
      service_key: nif_sk,
      batch_identifier: '123',
      transactions: transactions,
      key_rows: [
        :account_reference,
        :account_name,
        :banking_detail_type,
        :bank_account_name,
        :bank_account_type,
        :branch_code,
        :filler,
        :bank_account_number,
        :amount
      ]
    ).generate_file
    binding.pry

    r = NetcashApi::Client.nif_client.call(:batch_file_upload,
      message: { service_key: nif_sk, file: f.read })
  end
end
