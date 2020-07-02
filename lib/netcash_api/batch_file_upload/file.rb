require 'csv'

module NetcashApi
  module BatchFileUpload
    class File
      attr_accessor :service_key,
        :software_vendor_key,
        :batch_identifier,
        :instruction,
        :transactions,
        :action_date

      def initialize(args)
        args.each { |key, value| send("#{key}=", value) }
      end

      def batch_file
        @_batch_file ||= file_string
      end

      def file_string
        CSV.open(temp_file, 'wb', col_sep: "\t") do |file|
          file << header_row
          file << key_record_row

          transactions.each do |tx|
            file << transaction_row(tx)
          end
          file << footer_row
        end

        file_string = temp_file.read
        temp_file.unlink

        return file_string
      end

      private

      def temp_file
        @_temp_file ||= Tempfile.new(["timestamp.to_i", ".txt"], encoding: 'utf-8')
      end

      def header_row
        NetcashApi::BatchFileUpload::Header.new(
          service_key: service_key,
          software_vendor_key: software_vendor_key,
          batch_identifier: batch_identifier,
          instruction: instruction,
          action_date: action_date
        ).row
      end

      def key_record_row
        NetcashApi::BatchFileUpload::KeyRecord.new(
          transactions: transactions
        ).row
      end

      def footer_row
        NetcashApi::BatchFileUpload::Footer.new(
          transaction_count: transactions.count,
          total_amount: transactions.map {|s| s[:amount]}.reduce(0, :+)
        ).row
      end

      def transaction_row(transaction)
        NetcashApi::BatchFileUpload::Transaction.new(
          transaction: transaction
        ).row
      end
    end
  end
end
