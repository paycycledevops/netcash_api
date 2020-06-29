module NetcashApi
  module BatchFileUpload
    module Report
      class LoadReport
        def initialize(file:)
          @file = file
        end

        def success?
          errors.empty?
        end

        def successful_with_errors?
          errors.map(&:id).compact.any?
        end

        def failed?
          errors.count == 1 && errors[0].id.nil?
        end

        def errors
          @_errors ||= Response.new(file: @file).report
        end
      end
    end
  end
end
