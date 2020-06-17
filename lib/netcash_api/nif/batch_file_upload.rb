require 'csv'

module NetcashApi
  module Nif
    class BatchFileUpload
      attr_accessor :service_key,
        :software_vendor_key,
        :batch_identifier,
        :transactions,
        :key_rows

      def initialize(args)
        args.each { |key, value| send("#{key}=", value) }
      end

      def generate_file
        CSV.open(file, 'wb', col_sep: "\t") do |file|
          puts header_row
          file << header_row

          puts key_record_row
          file << key_record_row

          transactions.each do |tx|
            puts transaction_row(tx)
            file << transaction_row(tx)
          end

          puts footer_row
          file << footer_row
        end
        return file
      end

      private

      def file
        @_file ||= Tempfile.new(["timestamp.to_i", ".txt"], encoding: 'utf-8')
      end

      def header_row
        NetcashApi::Nif::BatchFile::Header.new(
          service_key: service_key,
          batch_identifier: batch_identifier,
          software_vendor_key: software_vendor_key
        ).row
      end

      def key_record_row
        NetcashApi::Nif::BatchFile::KeyRecord.new(
          key_rows: key_rows
        ).row
      end

      def footer_row
        NetcashApi::Nif::BatchFile::Footer.new(
          transaction_count: transactions.count,
          total_amount: transactions.map {|s| s[:amount]}.reduce(0, :+)
        ).row
      end

      def transaction_row(transaction)
        NetcashApi::Nif::BatchFile::Transaction.new(
          transaction: transaction,
          key_rows: key_rows
        ).row
      end
    end
  end
end
