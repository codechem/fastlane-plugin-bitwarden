module Fastlane
  module Actions
    class BitwardenUnlockVaultAction < Action
      def self.run(params)
        @helper = Helper::BitwardenHelper.new(params[:cli_path])
        password = params[:password]

        UI.message("Unlocking vault...")

        session = @helper.exec('unlock', password, '--raw')
        Actions.lane_context[SharedValues::BW_SESSION] = session
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "You can use this action to download an item's attachment from BitWarden."
      end

      def self.details
        "You can use this action to download an item's attachment from BitWarden."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :cli_path,
                                       env_name: "BW_CLI_PATH",
                                       optional: true,
                                       description: "Override path to the Bitwarden CLI"),
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "BW_PASSWORD",
                                       description: "Master Password to use when signing in to Bitwarden",
                                       verify_block: proc do |value|
                                         UI.user_error!("No Password provided to the Bitwarden Login Action `email: '<...email...>'`") unless value && !value.empty?
                                       end)
        ]
      end

      def self.output
        [
          ['BW_SESSION', 'The session token that Bitwarden returns']
        ]
      end

      def self.return_value
        "The BW_SESSION token"
      end

      def self.authors
        ["ilija@codechem.com"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
