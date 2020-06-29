RSpec.describe NetcashApi::StandardDebitOrder do
  let(:nif_sk) { 'd930eccd-3a6c-40b5-a611-831a72d012c4' }
  let(:accounts_sk) { '4724c261-dad5-4a64-852c-9b88a67b3c50' }

  let(:transactions) { attributes_for_list :transaction, 5 }

  subject { NetcashApi::StandardDebitOrder }

  it do
    file = NetcashApi::BatchFileUpload::File.new(
      service_key: nif_sk,
      software_vendor_key: accounts_sk,
      batch_identifier: '123',
      transactions: transactions
    ).batch_file

    subject.batch_file_upload(
      service_key: nif_sk,
      file: file
    )
  end

  let(:response) { File.read('spec/fixtures/batch_file_report_file.txt') }
  let(:load_report) { NetcashApi::BatchFileUploadReport::File.new(file: response) }

  it do
    expect(load_report.report.count).to be 5
  end
end
