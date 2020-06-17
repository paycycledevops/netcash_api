module NetcashApi::Nif::BatchFile
  class Header
    VERSION = '1'
    attr_accessor :service_key,
      :instruction,
      :batch_identifier,
      :action_date,
      :software_vendor_key

    def initialize(service_key:, instruction: nil, batch_identifier:, action_date: nil, software_vendor_key:)
      @service_key = service_key
      @instruction = instruction
      @batch_identifier = batch_identifier
      @action_date = action_date
      @software_vendor_key = software_vendor_key
    end

    def row
      [
        'H',
        service_key,
        VERSION,
        instruction || 'TwoDay',
        batch_identifier,
        action_date || Date.today.strftime('%Y%m%d'),
        software_vendor_key || '24ade73c-98cf-47b3-99be-cc7b867b3080'
      ]
    end
  end
end
