module NetcashApi
  module BatchFileUpload
    module Report
      class Line
        attr_accessor :line

        def initialize(line:)
          @line = line
        end

        def error
          return nil if line_parts.empty?
          Error.new(line_parts: line_parts[0])
        end

        private
        def line_parts
          file_error = line.scan(/###ERROR: (\S.*$)/)

          if file_error.empty?
            line.scan(/Acc Ref :(\w+) Line :(\d) (\S.*$)/)
          else
            file_error
          end
        end
      end
    end
  end
end
