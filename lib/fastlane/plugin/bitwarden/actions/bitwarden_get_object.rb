require_relative '../helper/bitwarden_helper'

module Fastlane
  module Actions
    module SharedValues
      BW_SESSION = :BW_SESSION
    end

    class BitwardenGetObjectAction < Action
      def self.run(params)
        @helper = Helper::BitwardenHelper.new(params[:cli_path])
        object_type = params[:object_type]
        other_args = params[:args] || {}
        str_args = params[:str_args] || ""

        args = ['get', object_type]

        args.push(str_args)

        other_args.each do |key, value|
          args.push(key.to_s)
          args.push(value)
        end

        args.push('--raw')

        @helper.exec(*args)
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
          FastlaneCore::ConfigItem.new(key: :object_type,
                                       description: "Type of the object to get (collection, item, etc.)",
                                       verify_block: proc do |value|
                                         UI.user_error!("No object type provided to the Bitwarden Get Object Action`") unless value && !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :args,
                                       description: "Other arguments (hash)",
                                       type: Hash,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :str_args,
                                       description: "Other arguments (string)",
                                       optional: true)
        ]
      end

      def self.output
        [
        ]
      end

      def self.return_value
        "The resulting object"
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
