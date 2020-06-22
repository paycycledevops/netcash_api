module NetcashApi::BatchFileUpload
  class Transaction
    ROW_IDENTIFIER = 'T'

    attr_accessor :transaction,
      :key_rows

    def initialize(transaction:)
      @transaction = transaction
    end

    def row
      [ ROW_IDENTIFIER ] + transaction.values
    end
  end
end
