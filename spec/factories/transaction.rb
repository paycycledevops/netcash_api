FactoryBot.define do
  factory :transaction, class: OpenStruct do
    account_reference { rand(999) }
    account_name { "Test Account Name #{account_reference}" }
    banking_detail_type { 1 }
    bank_account_name { "Test Bank Account #{account_reference}" }
    bank_account_type { 1 }
    branch_code { 632005 }
    filler { 0 }
    bank_account_number { 123456789 }
    amount { 5000 }
  end
end
