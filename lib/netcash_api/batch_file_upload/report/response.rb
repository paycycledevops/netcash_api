module NetcashApi
  module BatchFileUpload
    module Report
      class Response
        attr_accessor :file

        def initialize(file:)
          @file = file
        end

        def report
          file.lines.map do |line|
            Line.new(line: line).error
          end.compact
        end
      end
    end
  end
end
