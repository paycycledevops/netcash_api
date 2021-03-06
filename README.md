# NetcashApi

A Ruby adapater for the Netcash API.
[Documentation](https://api.netcash.co.za/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'netcash_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install netcash_api

## Bank Account Validation

#### METHOD /ValidateBankAccount

```ruby
netcash_params = {
  service_key: ENV['VALIDATIONS_SERVICE_KEY'],
  account_number: 123456789,
  branch_code: 632005,
  account_type: 1
}

NetcashApi::Validation.validate_bank_account(netcash_params) do |response|
  p response.body
  # => {:validate_bank_account_response=>{:validate_bank_account_result=>"0", :@xmlns=>"http://tempuri.org/"}}
end
```

## Standard Debit Order

#### Generate a batch file
To generate a batch file you will need a list of transactions. The transactions are based on the format supplied here: [Offical Netcash Doc](https://api.netcash.co.za/inbound-payments/standard-debit-orders/)

```ruby
transactions = [
  {
    account_reference: 1,
    account_name: 'Test Account',
    banking_detail_type: 1,
    bank_account_name: 'Test Bank Account',
    bank_account_type: 1,
    branch_code: 632005,
    bank_account_number: 123456789,
    amount: 50000
  }
]

batch_file_upload = NetcashApi::BatchFileUpload::File.new(
  service_key: ENV['ACCOUNT_SERVICE_KEY'],
  software_vendor_key: ENV['SOFTWARE_VENDOR_KEY'],
  batch_identifier: 1234,
  transactions: transactions
)

p batch_file_upload.batch_file_upload
# =>
# H SOFTWARE_VENDOR_KEY	1	SameDay	123	20200701	DIRECT_DEBIT_SERVICE_KEY
# K	101	102	131	132	133	134	135	136	162
# T	670	Test Account  1	Test Bank Account	1	632005	0	123456789	50000
# F	5	50000	9999

```
*** The key row will be generated based on the columns supplied.*

#### METHOD /BatchFileUpload

```ruby
response = NetcashApi::StandardDebitOrder.batch_file_upload(
  service_key: ENV['ACCOUNT_SERVICE_KEY'],
  file: batch_file_upload.batch_file
)
token = response.body.dig(:batch_file_upload_response, :batch_file_upload_result)
# => 20000000.2550236530.0483.2.2
```

#### METHOD /BatchFileUploadReport

```Ruby
response = NetcashApi::StandardDebitOrder.request_file_upload_report(
  service_key: ENV['ACCOUNT_SERVICE_KEY'],
  file_token: token)
response.body.dig(:request_file_upload_report_response, :request_file_upload_report_result)

# =>
# ###BEGIN MY TEST BATCH SUCCESSFUL 01:59 PM R1.00 20160410
# ###END 01:59 PM
```

## Statement

```ruby
response = NetcashApi::StandardDebitOrder.request_interim_merchant_statement(
  service_key: ENV['ACCOUNT_SERVICE_KEY'],
)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/netcash_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NetcashApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/netcash_api/blob/master/CODE_OF_CONDUCT.md).
