module NetcashApi::BatchFileUpload
  class Footer

    attr_accessor :total_amount,
      :transaction_count

    def initialize(transaction_count:, total_amount:)
      @transaction_count = transaction_count
      @total_amount = total_amount
    end

    def row
      [
        'F',
        transaction_count,
        total_amount,
        '9999'
      ]
    end
  end
end
