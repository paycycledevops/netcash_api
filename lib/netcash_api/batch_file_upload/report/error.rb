module NetcashApi
  module BatchFileUpload
    module Report
      class Error
        def initialize(line_parts:)
          @line_parts = line_parts
        end

        def id
          @line_parts[0]
        end

        def message
          @line_parts[1]
        end
      end
    end
  end
end
