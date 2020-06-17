FactoryBot.define do
  factory :transaction, class: OpenStruct do
    account_name { 'Test Account Name' }
    account_reference { rand(999) }
    banking_detail_type { 1 }
    bank_account_name { 'Test Bank Account' }
    bank_account_type { 1 }
    branch_code { 123400 }
    filler { 0 }
    bank_account_number { rand(99999999) }
    amount { 5000 }
  end
end
