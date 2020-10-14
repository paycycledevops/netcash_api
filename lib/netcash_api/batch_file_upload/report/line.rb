module NetcashApi
  module BatchFileUpload
    module Report
      class Line
        attr_accessor :line

        def initialize(line:)
          @line = line
        end

        def error
          return nil if line_parts.blank?
          Error.new(line_parts: line_parts)
        end

        private
        def line_parts
          parts = line.split("\t")

          case
          when parts[0].start_with?('Acc Ref :')
            [parts[3], parts[2]]
          when parts[0].start_with?('###ERROR')
            [nil, parts[0].scan(/###ERROR: (\S.*$)/)[0][0]]
          end
        end
      end
    end
  end
end
