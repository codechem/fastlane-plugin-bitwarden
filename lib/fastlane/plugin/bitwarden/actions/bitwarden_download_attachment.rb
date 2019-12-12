require_relative '../helper/bitwarden_helper'

module Fastlane
  module Actions
    class BitwardenDownloadAttachmentAction < Action
      def self.run(params)
        @helper = Helper::BitwardenHelper.new(params[:cli_path])
        item_id = params[:item_id]
        attachment_id = params[:attachment_id]
        output_path = params[:output_path]
        args = ['get', 'attachment', '--itemid', item_id, attachment_id, '--raw']
        if output_path
          args += ['--output', output_path]
        end

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
          FastlaneCore::ConfigItem.new(key: :item_id,
                                       env_name: "BW_ITEM_ID",
                                       description: "ID of the item the Attachment belongs to",
                                       verify_block: proc do |value|
                                          UI.user_error!("No Item ID provided to the Bitwarden Download Attachment Action, pass it like so: `item_id: '<...item_id...>'`") unless value and not value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :attachment_id,
                                       env_name: "BW_ATTACHMENT_ID",
                                       description: "ID of the Attachment to be downloaded",
                                       verify_block: proc do |value|
                                          UI.user_error!("No Attachment ID provided to the Bitwarden Download Attachment Action `email: '<...attachment_id...>'`") unless value and not value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :output_path,
                                       env_name: "BW_ATTACHMENT_OUTPUT",
                                       description: "Output path of the Attachment to be downloaded",
                                       optional: true),
        ]
      end

      def self.output
        [
        ]
      end

      def self.return_value
        "The resulting file path"
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
