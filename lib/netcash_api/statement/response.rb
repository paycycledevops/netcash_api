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
          h = column_defs.zip(r).to_h
          description = (h[:description] ||= '').split('- Code: ')
          h[:amount] = h[:amount].to_f
          h[:error_code] = description.count > 1 ? description[-1] : nil
          h
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
