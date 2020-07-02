RSpec.describe NetcashApi::StandardDebitOrder do
  let(:account_sk) { ENV['ACCOUNT_SERVICE_KEY'] }

  context 'request interim merchant statement' do
    it do
      VCR.use_cassette 'request_interim_merchant_statement' do
        response = subject.request_interim_merchant_statement(
          service_key: account_sk
        )

        expect(response.body.dig(:request_interim_merchant_statement_response, :request_interim_merchant_statement_result).length).to eq 18
      end
    end
  end


  context 'retrieve statement' do
    it do
      VCR.use_cassette 'retrieve_merchant_statement' do
        response = subject.retrieve_merchant_statement(
          service_key: account_sk,
          polling_id: '637291584000000000'
        )

        expect(response.body.dig(:request_interim_merchant_statement_response, :request_interim_merchant_statement_result).length).to eq 18
      end
    end
  end

  context 'statement response' do
    let(:file) { File.read('spec/fixtures/statement.txt') }

    it do
      statement = NetcashApi::Statement::Response.new(file: file)
      expect(statement.rows.count).to eq 39
      expect(statement.records.first.keys).to eq statement.column_defs
    end
  end
end
