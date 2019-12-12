require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class BitwardenHelper
      def initialize(cli_path)
        @cli_path = cli_path || "bw"
      end

      def exec(*command, log: false, error_callback: nil)
        ENV['BW_SESSION'] = Actions.lane_context[Actions::SharedValues::BW_SESSION]
        command.insert(0, @cli_path)
        res = Fastlane::Actions::sh(*command, log: log, error_callback: error_callback)
        ENV.delete('BW_SESSION')
        res
      end
    end
  end
end
