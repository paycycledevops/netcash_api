RSpec.describe NetcashApi::StandardDebitOrder do
  let(:nif_sk) { '12345' }
  let(:accounts_sk) { '67890' }

  let(:transactions) { attributes_for_list :transaction, 5 }

  subject { NetcashApi::StandardDebitOrder }

  context 'batch file upload' do
    it do
      file = NetcashApi::BatchFileUpload::File.new(
        service_key: nif_sk,
        software_vendor_key: accounts_sk,
        batch_identifier: '123',
        transactions: transactions
      ).batch_file

      VCR.use_cassette 'batch_file_upload' do
        response = subject.batch_file_upload(
          service_key: nif_sk,
          file: file
        )

        expect(response.body.dig(:batch_file_upload_response, :batch_file_upload_result).length).to eq 34
      end
    end
  end

  context 'batch file upload report' do
    let(:response) { File.read('spec/fixtures/batch_file_report_file.txt') }
    let(:load_report) { NetcashApi::BatchFileUploadReport::File.new(file: response) }

    it do
      expect(load_report.report.count).to be 5
    end
  end
end
