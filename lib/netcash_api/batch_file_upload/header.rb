module NetcashApi::BatchFileUpload
  class Header
    VERSION = '1'
    attr_accessor :service_key,
      :software_vendor_key,
      :batch_identifier,
      :instruction,
      :action_date

    def initialize(service_key:, instruction: nil, batch_identifier:, action_date: nil, software_vendor_key:)
      @service_key = service_key
      @software_vendor_key = software_vendor_key
      @batch_identifier = batch_identifier
      @instruction = instruction
      @action_date = action_date
    end

    def row
      [
        'H',
        service_key,
        VERSION,
        instruction || 'SameDay',
        batch_identifier,
        action_date || (Date.today + 5).strftime('%Y%m%d'),
        software_vendor_key || '24ade73c-98cf-47b3-99be-cc7b867b3080'
      ]
    end
  end
end
