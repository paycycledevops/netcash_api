module NetcashApi
  module BatchFileUpload
    module Report
      class Error
        def initialize(line_parts:)
          @line_parts = line_parts
        end

        def id
          return nil if file_error?
          @line_parts[0]
        end

        def line_number
          return nil if file_error?
          @line_parts[1]
        end

        def message
          @line_parts[-1]
        end

        private
        def file_error?
          @line_parts.count <= 2
        end
      end
    end
  end
end
