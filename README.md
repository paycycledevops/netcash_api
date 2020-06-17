# NetcashApi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/netcash_api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'netcash_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install netcash_api

## Direct Debit Orders

### Generate batch file

To generate a batch file you will need a list of transactions. The transactions are based on the format supplied here: [Offical Netcash Doc](https://api.netcash.co.za/inbound-payments/standard-debit-orders/)

```ruby

transactions = [
  {
    account_name: nil,
    account_active: nil,
    delete_this_account: nil,
    banking_detail_type: nil,
    bank_account_name: nil,
    bank_account_type: nil,
    branch_code: nil,
    filler: nil,
    bank_account_number: nil,
    masked_credit_card_number: nil,
    default_debit_amount: nil,
    amount: nil,
    email_address: nil,
    mobile_number: nil,
    debit_masterfile_group: nil,
    extra_1: nil,
    extra_2: nil,
    extra_3: nil,
    resubmit_unpaids_via_pay_now: nil
  }
]
```

You will also need to supply a key row, which is an array of all columns that will be used in the file. Any of the above fields can be selected.

**E.g.**

```ruby
key_row = [
    :account_name,
    :bank_account_name,
    :bank_account_type,
    :branch_code,
    :bank_account_number,
    :amount
]
```

Lastly, you will need your service key
```ruby
batch_file = NetcashApi::Nif::BatchFileUpload.new(
  service_key: NIF_SERVICE_KEY,
  software_vendor_key: SOFTWARE_VENDOR_KEY,
  batch_identifier: UNIQUE_BATCH_ID,
  transactions: transactions,
  key_rows: key_rows
).generate_file

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/netcash_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NetcashApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/netcash_api/blob/master/CODE_OF_CONDUCT.md).
