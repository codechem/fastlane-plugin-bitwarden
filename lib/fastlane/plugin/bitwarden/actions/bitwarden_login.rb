module Fastlane
  module Actions
    class BitwardenLoginAction < Action
      def self.ensure_login
        UI.message("Logging in to " + @server_url)
        @helper.exec('config', 'server', @server_url)
        UI.message("Checking login")
        @helper.exec('login', '--check', error_callback: method(:bw_login))
        Actions::BitwardenUnlockVaultAction.run(cli_path: @cli_path, password: @password)
      end

      def self.bw_login(result)
        session = @helper.exec('login', @email, @password, '--raw')
        Actions.lane_context[SharedValues::BW_SESSION] = session
      end

      def self.run(params)
        @cli_path = params[:cli_path]
        @server_url = params[:server_url]
        @email = params[:email]
        @password = params[:password]
        @helper = Helper::BitwardenHelper.new(@cli_path)
        self.ensure_login
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "You can use this action to login to BitWarden and unlock the vault."
      end

      def self.details
        "You can use this action to login to BitWarden and unlock the vault."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :cli_path,
                                       env_name: "BW_CLI_PATH",
                                       optional: true,
                                       description: "Override path to the Bitwarden CLI"),

          FastlaneCore::ConfigItem.new(key: :server_url,
                                       env_name: "BW_SERVER_URL",
                                       description: "Server URL use when signing in to Bitwarden",
                                       default_value: "https://bitwarden.com",
                                       verify_block: proc do |value|
                                          UI.user_error!("No Server URL provided to the Bitwarden Login Action, pass it like so: `server_url: '<...server_url...>'`") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :email,
                                       env_name: "BW_EMAIL",
                                       description: "Email to use when signing in to Bitwarden",
                                       verify_block: proc do |value|
                                          UI.user_error!("No Email provided to the Bitwarden Login Action, pass it like so: `email: '<...email...>'`") unless value && !value.empty?
                                       end),
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
