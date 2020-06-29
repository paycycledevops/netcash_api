RSpec.describe NetcashApi::BatchFileUpload::Report::LoadReport do
  let(:error) { File.read('spec/fixtures/batch_file_report_file_error.txt') }
  let(:failure) { File.read('spec/fixtures/batch_file_report_file_failures.txt') }
  let(:success) { File.read('spec/fixtures/batch_file_report_file_success.txt') }

  context 'error' do
    let(:load_report) { NetcashApi::BatchFileUpload::Report::LoadReport.new(file: error) }

    it do
      expect(load_report.success?).to be false
      expect(load_report.failed?).to be true
      expect(load_report.errors.count).to be 1
      expect(load_report.errors[0].id).to be nil
      expect(load_report.errors[0].message).to eq 'A system error occurred. Please contact Netcash R0.00 20160410'
    end
  end

  context 'successful with errors' do
    let(:load_report) { NetcashApi::BatchFileUpload::Report::LoadReport.new(file: failure) }

    it do
      expect(load_report.success?).to be false
      expect(load_report.success_with_errors?).to be true
      expect(load_report.errors.count).to be 4
      expect(load_report.errors[0].id).to eq 'XI5'
      expect(load_report.errors[0].line_number).to eq '3'
      expect(load_report.errors[0].message).to eq 'Account details could not be validated. Please check the fields Bank account type, Branch code and Account number.'
    end
  end

  context 'successful' do
    let(:load_report) { NetcashApi::BatchFileUpload::Report::LoadReport.new(file: success) }

    it do
      expect(load_report.success?).to be true
      expect(load_report.success_with_errors?).to be false
      expect(load_report.failed?).to be false
      expect(load_report.errors).to eq []
    end
  end
end
