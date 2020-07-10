module NetcashApi
  module Statement
    class Response
      attr_accessor :file

      def initialize(file:)
        @file = file
      end

      def rows
        file.lines.map { |l| l.strip.split(/\t/) }
      end

      def records
        rows.map { |r|
          column_defs.zip(r).to_h
        }
      end

      def column_defs
        [
          :transaction_date,
          :transaction_type,
          :transaction_id,
          :description,
          :amount,
          :symbol,
          :vat,
          :extra_1,
          :extra_2,
          :extra_3,
          :accounting_ledger_description
        ]
      end
    end
  end
end
