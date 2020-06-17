module NetcashApi::Nif::BatchFile
  class Transaction
    ROW_IDENTIFIER = 'T'

    attr_accessor :transaction,
      :key_rows

    def initialize(transaction:, key_rows:)
      @transaction = transaction
      @key_rows = key_rows
    end

    def row
      r = key_rows.map { |key| transaction[key] }
      [ ROW_IDENTIFIER ] + r
    end
  end
end
