RSpec.describe NetcashApi::Statement do
  let(:account_sk) { ENV['ACCOUNT_SERVICE_KEY'] }

  let(:client) { NetcashApi::StandardDebitOrder }

  context 'request interim merchant statement' do
    it do
      response = VCR.use_cassette 'statement' do
        client.request_merchant_statement(
          service_key: account_sk,
          from_action_date: '20200703'
        )
      end

      polling_id = response.body.dig(:request_merchant_statement_response, :request_merchant_statement_result)

      statement_result = VCR.use_cassette 'statement2' do
        client.retrieve_merchant_statement(
          service_key: account_sk,
          polling_id: polling_id
        )
      end

      statement = statement_result.body.dig(:retrieve_merchant_statement_response, :retrieve_merchant_statement_result)
      statement_object = NetcashApi::Statement::Response.new(file: statement)
      expect(statement_object.records.count).to eq 5
      binding.pry
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
