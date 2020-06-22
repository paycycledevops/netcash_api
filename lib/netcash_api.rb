require 'savon'

require 'netcash_api/batch_file_upload/file'
require 'netcash_api/batch_file_upload/footer'
require 'netcash_api/batch_file_upload/header'
require 'netcash_api/batch_file_upload/key_record'
require 'netcash_api/batch_file_upload/transaction'

require 'netcash_api/services/xml_key_adapter'

require 'netcash_api/client'
require 'netcash_api/validation'
require 'netcash_api/standard_debit_order'

module NetcashApi
  class Error < StandardError; end
  # Your code goes here...
end
