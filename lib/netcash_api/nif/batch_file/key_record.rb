module NetcashApi::Nif::BatchFile
  class KeyRecord
    ROW_IDENTIFIER ='K'

    attr_accessor :key_rows

    def initialize(key_rows:)
      @key_rows = key_rows
    end

    def row
      r = key_rows.map { |kr| keys[kr] }
      [ ROW_IDENTIFIER ] + r
    end

    private

    def keys
      {
        account_reference: 101,
        account_name: 102,
        account_active: 103,
        delete_this_account: 104,
        banking_detail_type: 131,
        bank_account_name: 132,
        bank_account_type: 133,
        branch_code: 134,
        filler: 135,
        bank_account_number: 136,
        masked_credit_card_number: 137,
        default_debit_amount: 161,
        amount: 162,
        email_address: 201,
        mobile_number: 202,
        debit_masterfile_group: 281,
        extra_1: 301,
        extra_2: 302,
        extra_3: 303,
        resubmit_unpaids_via_pay_now: 509
      }
    end
  end
end
