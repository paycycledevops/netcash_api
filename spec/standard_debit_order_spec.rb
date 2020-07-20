RSpec.describe NetcashApi::StandardDebitOrder do
  let(:account_sk) { ENV['DEBIT_ORDER_SERVICE_KEY'] }
  let(:software_vendor_key) { ENV['SOFTWARE_VENDOR_KEY'] }

  let(:transactions) { attributes_for_list :transaction, 5 }

  subject { NetcashApi::StandardDebitOrder }

  context 'batch file upload' do
    it do
      file = NetcashApi::BatchFileUpload::File.new(
        service_key: account_sk,
        software_vendor_key: software_vendor_key,
        batch_identifier: '1234',
        transactions: transactions
      ).batch_file

      VCR.use_cassette 'batch_file_upload' do
        response = subject.batch_file_upload(
          service_key: account_sk,
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

  context 'retrieve unauthorised batches' do
    it do
      VCR.use_cassette 'retrieve_unauthorised_batches' do
        response = subject.retrieve_unauthorised_batches(
          service_key: account_sk
        )

        binding.pry

        expect(response.body.dig(:request_interim_merchant_statement_response, :request_interim_merchant_statement_result).length).to eq 18
      end
    end
  end

end
